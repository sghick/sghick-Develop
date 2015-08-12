//
//  SMBll.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMBll.h"
#import "SMNetManager.h"
#import "SMUrlRequest.h"
#import "SMRequestQueue.h"

@implementation SMBll

- (void)addRequest:(SMUrlRequest *)request {
    [self addRequest:request useCache:request.useCache];
}

- (void)addRequest:(SMUrlRequest *)request useCache:(BOOL)useCache {
    [self addRequest:request useCache:useCache useQueue:NO];
}

- (void)addRequest:(SMUrlRequest *)request useQueue:(BOOL)useQueue {
    [self addRequest:request useCache:NO useQueue:useQueue];
}

- (void)addRequest:(SMUrlRequest *)request useCache:(BOOL)useCache useQueue:(BOOL)useQueue {
    if (useCache) {
        if ([self respondsToSelector:@selector(cacheDBWithRequest:)]) {
            [self cacheDBWithRequest:request];
        }
    }
    [SMNetManager addRequest:request];
    if (useQueue) {
        [[SMRequestQueue shareInstance] enqueue:request];
    }
}

- (void)requestQueueWithTimesOut:(NSInteger)timesOut cancelAllRequest:(BOOL)cancelAllRequest {
    if (cancelAllRequest) {
        [self cancelAllRequest];
    }
    SMRequestQueue *queue = [SMRequestQueue shareInstance];
    while (![queue isEmpty]) {
        SMUrlRequest *request = [queue dequeue];
        if (request.requestCount < timesOut) {
            request.requestCount++;
            [self addRequest:request useQueue:YES];
        }
    }
}

- (void)cancelAllRequest {
    [SMNetManager cancelAllTask];
}

@end
