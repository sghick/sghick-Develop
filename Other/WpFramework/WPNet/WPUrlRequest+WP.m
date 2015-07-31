//
//  WPUrlRequest+WP.m
//  WisdomPark
//
//  Created by 丁治文 on 15/2/12.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPUrlRequest+WP.h"
#import "WPNetManager.h"

@implementation WPUrlRequest (WP)

/**
 *  开始请求
 */
- (void)startInQueue{
    [WPNetManager addRequest:self];
}

/**
 *  取消所有请求
 */
- (void)cancelAll{
    [WPNetManager cancelAllTask];
}

@end
