//
//  SMRequestQueue.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/12.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMRequestQueue.h"
#import "SMUrlRequest.h"

@interface SMRequestQueue ()

@property (strong, nonatomic) NSMutableArray *requests;

@end

@implementation SMRequestQueue

+ (instancetype)shareInstance {
    static SMRequestQueue *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SMRequestQueue alloc] init];
        instance.requests = [NSMutableArray array];
    });
    return instance;
}

- (NSInteger)count {
    return self.requests.count;
}

- (BOOL)isEmpty {
    return !self.requests.count;
}

- (BOOL)containsRequest:(SMUrlRequest *)request compareWithKey:(BOOL)compareWithKey {
    if ([self.requests containsObject:request]) {
        return YES;
    } else {
        if (compareWithKey) {
            for (SMUrlRequest *rq in self.requests) {
                if ([request.key isEqualToString:rq.key]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (void)removeRequest:(SMUrlRequest *)request compareWithKey:(BOOL)compareWithKey {
    if (!compareWithKey) {
        [self.requests removeObject:request];
    } else {
        for (SMUrlRequest *rq in self.requests) {
            if ([request.key isEqualToString:rq.key]) {
                [self.requests removeObject:rq];
            }
        }
    }
}

- (NSArray *)requestsInQueue {
    return self.requests;
}

- (void)enqueue:(SMUrlRequest *)request {
    [self.requests addObject:request];
}

- (SMUrlRequest *)dequeue {
    if (![self isEmpty]) {
        SMUrlRequest *request = self.requests.lastObject;
        [self.requests removeLastObject];
        return request;
    }
    SMLog(@"request队列已经空空如也了，没有对象能再出列了！");
    return nil;
}

- (void)clear {
    [self.requests removeAllObjects];
}

@end
