//
//  SampleBll.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SampleBll.h"
#import "SMModel.h"
#import "SMUrlRequest.h"
#import "SampleAPI.h"
#import "SampleDao.h"
#import "SMRequestQueue.h"
#import "SMResult.h"
#import "SMJoke.h"

static NSString *kRequestGetTestData = @"kRequestGetTestData";
static NSString *kRequestPostTestData = @"kRequestPostTestData";
static NSString *kRequestFileTestData = @"kRequestFileTestData";
static NSString *kRequestLocalTestData = @"kRequestLocalTestData";

@interface SampleBll ()

@property (strong, nonatomic) SMRequestQueue *queue;
@property (strong, nonatomic) SampleAPI *api;
@property (strong, nonatomic) SampleDao *dao;

@end

@implementation SampleBll

- (instancetype)init {
    self = [super init];
    if (self) {
        SMRequestQueue *queue = [SMRequestQueue shareInstance];
        self.queue = queue;
        
        SampleAPI *api = [[SampleAPI alloc] initWithDelegate:self finishedSelector:@selector(finishedAction:) faildSelector:@selector(faildAtion:)];
        self.api = api;
        
        SampleDao *dao = [[SampleDao alloc] init];
        self.dao = dao;
    }
    return self;
}

#pragma mark - request
- (void)requestGetTestDataWithParam:(SMModel *)param {
    SMUrlRequest *request = [self.api requestGetTestWithParam:param];
    request.key = kRequestGetTestData;
    [self addRequest:request useCache:YES useQueue:YES];
}

- (void)requestPostTestDataWithParam:(SMModel *)param {
    SMUrlRequest *request = [self.api requestPostTestWithParam:param];
    request.key = kRequestPostTestData;
    request.useCache = YES;
    request.cacheTimeOut = 1000;
    [self addRequest:request];
}

- (void)requestFileTestDataWithParam:(SMModel *)param {
    SMUrlRequest *request = [self.api requestFILETestWithParam:param];
    request.key = kRequestFileTestData;
    [self addRequest:request];
}

- (void)requestLocalTestData {
    SMUrlRequest *request = [self.api requestLocalTest];
    request.key = kRequestLocalTestData;
    [self addRequest:request];
}

#pragma mark - request - responds
- (void)finishedAction:(SMUrlRequest *)request {
    // 删除队列中的请求
    [self.queue removeRequest:request compareWithKey:NO];
    if ([kRequestGetTestData isEqualToString:request.key]) {
        SMResult *result = request.responseParserObject;
        // 手动缓存
        [self.dao deleteJokes];
        [self.dao insertJokes:result.detail];
        if ([self.delegate respondsToSelector:@selector(respondsGetTestData:)]) {
            [self.delegate respondsGetTestData:result.detail];
        }
    } else if ([kRequestPostTestData isEqualToString:request.key]) {
        SMResult *result = request.responseParserObject;
        if ([self.delegate respondsToSelector:@selector(respondsPostTestData:)]) {
            [self.delegate respondsPostTestData:result.detail];
        }
    } else if ([kRequestFileTestData isEqualToString:request.key]) {
        if ([self.delegate respondsToSelector:@selector(respondsFileTestData:)]) {
            [self.delegate respondsFileTestData:nil];
        }
    } else if ([kRequestLocalTestData isEqualToString:request.key]) {
        SMResult *result = request.responseParserObject;
        if ([self.delegate respondsToSelector:@selector(respondsLocalTestData:)]) {
            [self.delegate respondsLocalTestData:result.detail];
        }
    }
}

- (void)faildAtion:(SMUrlRequest *)request {
    // 请求失败, 每个请求最多重试5次
    [self requestQueueWithTimesOut:5 cancelAllRequest:YES];
    if ([self.delegate respondsToSelector:@selector(respondsFaildWithErrorCode:)]) {
        [self.delegate respondsFaildWithErrorCode:request.responseErrorCode];
    }
}

#pragma mark - SMBllCacheDelegate
- (void)cacheDBWithRequest:(SMUrlRequest *)request {
    if ([kRequestGetTestData isEqualToString:request.key]) {
        // 手动缓存
        NSArray *array = [self.dao searchJokes];
        if ([self.delegate respondsToSelector:@selector(respondsGetTestData:)]) {
            [self.delegate respondsGetTestData:array];
        }
    // 自动缓存
    } else if ([kRequestPostTestData isEqualToString:request.key]) {
        SMResult *result = request.responseParserCacheObject;
        if ([self.delegate respondsToSelector:@selector(respondsGetTestData:)]) {
            [self.delegate respondsPostTestData:result.detail];
        }
    }
}

#pragma mark - File

@end
