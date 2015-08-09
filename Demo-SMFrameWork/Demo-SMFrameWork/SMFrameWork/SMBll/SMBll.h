//
//  SMBll.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMUrlRequest;
@protocol SMBllCacheDelegate <NSObject>

@optional;
- (void)cacheDBWithRequest:(SMUrlRequest *)request;

@end

@class SMUrlRequest;
@interface SMBll : NSObject <
SMBllCacheDelegate
>

@property (assign, nonatomic) id delegate;

- (void)addRequest:(SMUrlRequest *)request;
- (void)addRequest:(SMUrlRequest *)request userCache:(BOOL)userCache;
- (void)cancelAllRequest;

@end
