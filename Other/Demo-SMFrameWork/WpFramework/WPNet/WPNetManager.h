//
//  WPNetManager.h
//  WisdomPark
//
//  Created by 丁治文 on 15/1/24.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WPNetStatusUnknown          = -1,
    WPNetStatusNotReachable     = 0,
    WPNetStatusReachableViaWWAN = 1,
    WPNetStatusReachableViaWiFi = 2,
}WPNetStatus;

@class WPUrlRequest;
@interface WPNetManager : NSObject

+ (void)addRequest:(WPUrlRequest *)request;

+ (void)cancelAllTask;

+ (WPNetStatus *)netStatus;

// 请求本地数据
+ (void)loadDataFromJsonFileWithRequest:(WPUrlRequest *)request;

@end
