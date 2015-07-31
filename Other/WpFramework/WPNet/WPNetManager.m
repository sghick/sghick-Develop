//
//  WPNetManager.m
//  WisdomPark
//
//  Created by 丁治文 on 15/1/24.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPNetManager.h"
#import "WPUrlRequest.h"
#import "WPAFNClient.h"


@implementation WPNetManager

+ (void)addRequest:(WPUrlRequest *)request{
    // 输入检测
    if (!request) {
        WpWarmLog(@"request不能为空");
        return;
    }
    if (!request.urlString) {
        WpWarmLog(@"未设置url");
        [request faild];
        return;
    }
    // 基本url
    NSString * baseUrl = WpBaseUrl;
    // 如果有异常操作，默认用北园区
    if (!baseUrl) {
        baseUrl = __WP_BASEURL_NORTH_;
    }
    // 本地数据local
    if ([baseUrl isEqualToString:[WpPosionSwitchDataSource objectForKey:WpPosion0]]) {
        [self loadDataFromJsonFileWithRequest:request];
        return;
    }
    // 拼接baseUrl
    if (![request.urlString hasPrefix:@"http://"]) {
        request.urlString = [baseUrl stringByAppendingString:request.urlString];
    }
    
    // 添加统一参数
    [WPNetManager fillRequestParams:request];
#warning 测试用 张杰
    if ([request.key isEqualToString:@"requestDaliyMeals"]) {
        [self loadDataFromJsonFileWithRequest:request];
        return;
    }
#warning end 测试 张杰
    [self loadDataFromAFNetWithRequest:request];
}

+ (void)loadDataFromAFNetWithRequest:(WPUrlRequest *)request{
    if ([requestMethodPost isEqualToString:request.requestMethod]) {
        [[WPAFNClient sharedClient] POST:request.urlString parameters:request.paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [request clearResponse];
            if (!responseObject) {
                WpDebugLog(@"POST请求数据为空: %@, %@", request.key, request.urlString);
                request.responseErrorCode = @"0";
                request.responseErrorMsg = @"POST请求数据为空";
                [request faild];
                return;
            }
            request.responseObject = responseObject;
            WpDebugLog(@"POST请求成功: %@, %@", request.key, request.urlString);
            WpDebugLog(@"=====>%@", responseObject);
            [request finished];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            WpDebugLog(@"POST请求失败: %@, %@", request.key, error);
            NSData * errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
            if (errorData) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
                request.responseErrorCode = [dict objectForKey:@"Code"];
                request.responseErrorMsg = [dict objectForKey:@"message"];
            }
            [request faild];
        }];
    }
    else if ([requestMethodGet isEqualToString:request.requestMethod]) {
        [[WPAFNClient sharedClient] GET:request.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [request clearResponse];
            if (!responseObject) {
                WpDebugLog(@"GET请求数据为空,程序即将崩溃: %@, %@", request.key, request.urlString);
                request.responseErrorCode = @"0";
                request.responseErrorMsg = @"GET请求数据为空";
                [request faild];
                return;
            }
            request.responseObject = responseObject;
            WpDebugLog(@"GET请求成功: %@, %@", request.key, request.urlString);
            [request finished];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            WpDebugLog(@"GET请求失败: %@, %@", request.key, error);
            [request faild];
        }];
    }
    else if ([requestMethodFile isEqualToString:request.requestMethod]){
        NSString * url = [WPNetManager urlStringFromRequest:request];
        [[WPAFNClient sharedClient] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (WPUrlRequestParamFile * file in request.paramsFiles) {
                if (file.fileName && file.mimeType) {
                    [formData appendPartWithFileData:file.data name:file.paramName fileName:file.fileName mimeType:file.mimeType];
                }
                else{
                    [formData appendPartWithFormData:file.data name:file.paramName];
                }
            }
        }success:^(AFHTTPRequestOperation *operation,id responseObject) {
       request.responseObject = responseObject;
            WpDebugLog(@"文件上传成功: %@, %@", request.key, request.urlString);
            [request finished];
        }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
            WpDebugLog(@"文件上传失败: %@, %@", request.key, error);
            [request faild];
        }];
    }
}

/**
 *  添加统一参数
 */
+ (void)fillRequestParams:(WPUrlRequest *)request{
#warning 测试添加temp 张杰 start
    // 添加统一参数
//    [request.paramsDict setObject:@"1" forKey:@"temp"];
#warning 测试添加temp 张杰 end
    // 取得session
    WPUserSession * userSeesion = [WPUserSession userSessionFromUserDefaults];
    if (![request.paramsDict objectForKey:@"userName"]) {
        if (userSeesion.userName) {
            [request.paramsDict setObject:[userSeesion userName] forKey:@"userName"];
        }
    }
    if (![request.paramsDict objectForKey:@"token"]) {
        if (userSeesion.userToken) {
            [request.paramsDict setObject:[userSeesion userToken] forKey:@"token"];
        }
    }
}

+ (NSString *)urlStringFromRequest:(WPUrlRequest *)request{
    NSString * url = [request.urlString stringByAppendingString:@"?"];
    for (NSString * key in request.paramsDict.allKeys) {
        url = [url stringByAppendingFormat:@"%@=%@&", key, [request.paramsDict objectForKey:key]];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

+ (void)loadDataFromJsonFileWithRequest:(WPUrlRequest *)request{
    NSString * path = [[NSBundle mainBundle] pathForResource:request.key ofType:@"json"];
    if (path) {
        [request clearResponse];
        NSData * data = [NSData dataWithContentsOfFile:path];
        if (!data) {

            WpDebugLog(@"Json请求数据为空,程序即将崩溃: %@, %@", request.key, request.urlString);
            request.responseErrorCode = @"0";
            request.responseErrorMsg = @"JSON请求数据为空";
            [request faild];
            return;
        }
        request.responseObject = data;
        WpDebugLog(@"Json获取成功: %@", request.key);
        [request finished];
    }
    else{
        WpDebugLog(@"Json获取失败: %@", request.key);
        [request faild];
    }
}

+ (void)cancelAllTask{
    [[[WPAFNClient sharedClient] operationQueue] cancelAllOperations];
}

+ (WPNetStatus *)netStatus{
    return (WPNetStatus *)[[WPAFNClient sharedClient] status];
}

@end
