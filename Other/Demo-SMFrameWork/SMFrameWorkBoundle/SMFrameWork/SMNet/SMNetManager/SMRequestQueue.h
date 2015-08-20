//
//  SMRequestQueue.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/12.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMUrlRequest;
@interface SMRequestQueue : NSObject

+ (instancetype)shareInstance;

- (NSInteger)count;
- (BOOL)isEmpty;
- (BOOL)containsRequest:(SMUrlRequest *)request compareWithKey:(BOOL)compareWithKey;

- (void)removeRequest:(SMUrlRequest *)request compareWithKey:(BOOL)compareWithKey;
- (NSArray *)requestsInQueue;
- (void)enqueue:(SMUrlRequest *)request;
- (SMUrlRequest *)dequeue;
- (void)clear;

@end
