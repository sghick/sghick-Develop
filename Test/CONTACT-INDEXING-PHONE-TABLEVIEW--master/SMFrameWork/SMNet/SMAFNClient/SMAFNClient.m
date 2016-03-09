//
//  SMAFNClient.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMAFNClient.h"
#import "SMLog.h"
#import "UIHeader.h"

@implementation SMAFNClient

- (instancetype)init {
    NSAssert2(YES, @"%@:本类为单例类，请调用-[%@ sharedClient]", kLogError, NSStringFromClass([self class]));
    return nil;
}

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    static SMAFNClient *sharedClient = nil;
    dispatch_once(&onceToken, ^{
#warning 测试地址
        //测试地址
        NSString *baseApiURL = @"www.baidu.com";
        //初始化客户端
        sharedClient = [[SMAFNClient alloc] initWithBaseURL:[NSURL URLWithString:baseApiURL]];
        //设置安全策略
        [sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        //设置网络变化的监控
        [sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            sharedClient.status = status;
            NSString *name = @"未知网络";
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    SMLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    SMLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
            SMLog(@"%@", name);
            NSDictionary *userInfo = @{
                                       @"status":[NSNumber numberWithInteger:status],
                                       @"name":name
                                       };
            [SMNotiCenter postNotificationName:SMAFNClientNetStateDidChangeNotification object:nil userInfo:userInfo];
        }];
        [sharedClient.reachabilityManager startMonitoring];
    });
    
#warning:根据需要设置
    //工程中server.php 对应php版本的服务器端
    
//    //发送json数据
//    sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
//    //响应json数据
//    sharedClient.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送二进制数据
    sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制数据
    sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
    //    设置响应内容格式
    
//    sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data", @"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
#warning:测试时用
    if ( __SM_DEBUG__ ) {
        // 设置请求超时间隔
        sharedClient.requestSerializer.timeoutInterval = 10;
    }
    
    return sharedClient;
    
}

@end
