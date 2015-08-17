//
//  SMUrlRequest+SM.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMUrlRequest.h"

@interface SMUrlRequest (SM)

/**
 *  开始请求
 */
- (void)startInQueue;

/**
 *  取消所有请求
 */
- (void)cancelAll;

@end
