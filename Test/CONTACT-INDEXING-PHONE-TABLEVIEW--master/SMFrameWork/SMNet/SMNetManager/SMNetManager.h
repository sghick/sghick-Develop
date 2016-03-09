//
//  SMNetManager.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SMNetStatusUnknown          = -1,
    SMNetStatusNotReachable     = 0,
    SMNetStatusReachableViaWWAN = 1,
    SMNetStatusReachableViaWiFi = 2,
}SMNetStatus;

@class SMUrlRequest;
@interface SMNetManager : NSObject

/**
 *  添加请求
 *所有请求都是通过这个方法
 *
 *  @param request 请求具体参数
 */
+ (void)addRequest:(SMUrlRequest *)request;

/**
 *  取消所有的请求任务
 */
+ (void)cancelAllTask;

/**
 *  返回网络状态
 *
 *  @return 网络状态
 */
+ (SMNetStatus)netStatus;

@end
