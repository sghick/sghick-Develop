//
//  SMUrlRequest+SM.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMUrlRequest+SM.h"
#import "SMNetManager.h"

@implementation SMUrlRequest (SM)

/**
 *  开始请求
 */
- (void)startInQueue{
    [SMNetManager addRequest:self];
}

/**
 *  取消所有请求
 */
- (void)cancelAll{
    [SMNetManager cancelAllTask];
}

@end
