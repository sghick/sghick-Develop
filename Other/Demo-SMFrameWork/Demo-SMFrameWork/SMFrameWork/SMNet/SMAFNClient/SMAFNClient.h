//
//  SMAFNClient.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#define URL_BASE __SM_BASEURL_
// 通知中心，获取网络状态
#define SMAFNClientNetStateDidChangeNotification @"_KEY__SMAFNClientNetStateDidChangeNotification__"

#import "AFHTTPRequestOperationManager.h"

@interface SMAFNClient : AFHTTPRequestOperationManager

@property (assign, nonatomic) AFNetworkReachabilityStatus status;

+ (instancetype)sharedClient;

@end
