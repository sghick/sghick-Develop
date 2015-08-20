//
//  WPAFNClient.m
//  WisdomPark
//
//  Created by 丁治文 on 15/1/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPAFNClient.h"

static dispatch_once_t onceToken;
static WPAFNClient *_sharedClient = nil;

@implementation WPAFNClient

+ (instancetype)sharedClient {
    
    dispatch_once(&onceToken, ^{
        //测试地址
        NSString *baseApiURL = @"www.baidu.com";
        _sharedClient = [[WPAFNClient alloc] initWithBaseURL:[NSURL URLWithString:baseApiURL]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _sharedClient.status = status;
            NSDictionary *dic = @{@"NetWorkStatus":AFStringFromNetworkReachabilityStatus(status)};
            [[NSNotificationCenter defaultCenter] postNotificationName:WPAFNClientNetStateDidChangeNotification object:nil userInfo:dic];
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    WpLog(@"3G网络已连接");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    WpLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    WpLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedClient.reachabilityManager startMonitoring];
    });
    
#warning:需要设置 很重要
    //TODO:需要设置 很重要
    //工程中server.php 对应php版本的服务器端
    
//    //发送json数据
//    _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
//    //响应json数据
//    _sharedClient.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送二进制数据
    _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制数据
//    _sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
//    设置响应内容格式
    
//    _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data", @"application/json", @"text/json", @"text/javascript",@"text/html", nil];

//    _sharedClient.responseSerializer.acceptableCoqntentTypes = [NSSet setWithObjects:@"multipart/form-data", @"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
#warning:测试时用
    // 设置发送延时
    _sharedClient.requestSerializer.timeoutInterval = 10;

    return _sharedClient;
    
}

@end
