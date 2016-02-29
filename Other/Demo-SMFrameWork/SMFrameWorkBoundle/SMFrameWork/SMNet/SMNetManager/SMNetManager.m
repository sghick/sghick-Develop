//
//  SMNetManager.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMNetManager.h"
#import "SMUrlRequest.h"
#import "SMAFNClient.h"
#import "SMConfig.h"
#import "SMLog.h"

@implementation SMNetManager

+ (void)addRequest:(SMUrlRequest *)request{
    
    if (__SM_USE_LOCAL_DATA__ || [request.requestMethod isEqualToString:requestMethodLocal]) {
        [self loadDataFromLocalFileWithRequest:request];
        return;
    } else {
        // 输入检测
        if (!request) {
            SMLog(@"%@:request不能为空", kLogWarming);
            return;
        }
        if (!request.URL) {
            SMLog(@"%@:未设置url", kLogWarming);
            [request faild];
            return;
        }
        // 拼接baseUrl
        
        // 统一添加请求参数
        [SMNetManager fillRequestParams:request];
        [self loadDataFromAFNetWithRequest:request];
    }
}

#pragma mark - DataManager
+ (void)loadDataFromAFNetWithRequest:(SMUrlRequest *)request {
    //根据请求参数的请求方法分为三种请求
    //第一种，POST请求
    if ([requestMethodPost isEqualToString:request.requestMethod]) {
        [[SMAFNClient sharedClient] POST:request.urlString parameters:request.paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //请求成功
            //清理request 内的response数据
            [request clearResponse];
            if (!responseObject) {
                SMLog(@"POST请求数据为空: %@, %@", request.key, request.urlString);
                request.responseErrorCode = @"0";
                request.responseErrorMsg = @"POST请求数据为空";
                [request faild];
                return;
            }
            //把返回的对象 传递给 request.responseObject
            request.responseObject = responseObject;
            SMLog(@"POST请求成功: %@, %@", request.key, request.urlString);
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                SMLog(@"===DATA==>%@", dict);
            } else {
                SMLog(@"===DICT==>%@", responseObject);
            }
            //执行request finished 方法
            [request finished];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            SMLog(@"POST请求失败: %@, %@", request.key, error);
            NSData * errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
            if (errorData) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
                request.responseErrorCode = [dict objectForKey:@"code"];
                request.responseErrorMsg = [dict objectForKey:@"message"];
            }
            [request faild];
        }];
    } else if ([requestMethodGet isEqualToString:request.requestMethod]) {
        [[SMAFNClient sharedClient] GET:request.urlString parameters:request.paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [request clearResponse];
            if (!responseObject) {
                SMLog(@"GET请求数据为空,程序即将崩溃: %@, %@", request.key, request.urlString);
                request.responseErrorCode = @"0";
                request.responseErrorMsg = @"GET请求数据为空";
                [request faild];
                return;
            }
            request.responseObject = responseObject;
            SMLog(@"GET请求成功: %@, %@", request.key, request.urlString);
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                SMLog(@"===DATA==>%@", dict);
            } else {
                SMLog(@"===DICT==>%@", responseObject);
            }
            [request finished];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            SMLog(@"GET请求失败: %@, %@", request.key, error);
            [request faild];
        }];
    } else if ([requestMethodFile isEqualToString:request.requestMethod]){
        NSString * url = [SMNetManager urlStringFromRequest:request];
        [[SMAFNClient sharedClient] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (SMUrlRequestParamFile * file in request.paramsFiles) {
                if (file.fileName && file.mimeType) {
                    [formData appendPartWithFileData:file.data name:file.paramName fileName:file.fileName mimeType:file.mimeType];
                }
                else{
                    [formData appendPartWithFormData:file.data name:file.paramName];
                }
            }
        }success:^(AFHTTPRequestOperation *operation,id responseObject) {
            request.responseObject = responseObject;
            SMLog(@"文件上传成功: %@, %@", request.key, request.urlString);
            [request finished];
        }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
            SMLog(@"文件上传失败: %@, %@", request.key, error);
            [request faild];
        }];
    }
}

+ (void)loadDataFromLocalFileWithRequest:(SMUrlRequest *)request {
    NSString * path = [[NSBundle mainBundle] pathForResource:request.key ofType:request.requestLocalPathExtension];
    if (path) {
        [request clearResponse];
        NSData * data = [NSData dataWithContentsOfFile:path];
        if (!data) {
            SMLog(@"Local请求数据为空,程序即将崩溃: %@, %@", request.key, request.urlString);
            request.responseErrorCode = @"0";
            request.responseErrorMsg = @"Local请求数据为空";
            [request faild];
            return;
        }
        request.responseObject = data;
        SMLog(@"Local获取成功: %@", request.key);
        [request finished];
    }
    else{
        SMLog(@"Local获取失败: %@", request.key);
        [request faild];
    }
}

#pragma mark - ()
/**
 *  统一添加请求参数
 *
 *  @param request 请求的request对象
 */
+ (void)fillRequestParams:(SMUrlRequest *)request{
    
}

+ (NSString *)urlStringFromRequest:(SMUrlRequest *)request{
    NSString * url = [request.urlString stringByAppendingString:@"?"];
    for (NSString * key in request.paramsDict.allKeys) {
        url = [url stringByAppendingFormat:@"%@=%@&", key, [request.paramsDict objectForKey:key]];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

+ (void)cancelAllTask{
    [[[SMAFNClient sharedClient] operationQueue] cancelAllOperations];
}

+ (SMNetStatus)netStatus{
    return (SMNetStatus)[[SMAFNClient sharedClient] status];
}

@end
