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

@implementation SMBll

- (void)addRequest:(SMUrlRequest *)request {
    [self addRequest:request userCache:request.userCache];
}

- (void)addRequest:(SMUrlRequest *)request userCache:(BOOL)userCache {
    if (userCache) {
        if ([self respondsToSelector:@selector(cacheDBWithRequest:)]) {
            [self cacheDBWithRequest:request];
        }
    }
    [SMNetManager addRequest:request];
}

- (void)cancelAllRequest {
    [SMNetManager cancelAllTask];
}

@end
