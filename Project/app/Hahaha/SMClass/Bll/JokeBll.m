//
//  JokeBll.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeBll.h"
#import "SMModel.h"
#import "SMUrlRequest.h"
#import "JokeAPI.h"
#import "JokeDao.h"
#import "SMRequestQueue.h"
#import "SMResult.h"
#import "SMJoke.h"

static NSString *kRequestJokeList = @"kRequestJokeList";

@interface JokeBll ()

@property (strong, nonatomic) SMRequestQueue *queue;
@property (strong, nonatomic) JokeAPI *api;
@property (strong, nonatomic) JokeDao *dao;

@end

@implementation JokeBll

- (instancetype)init {
    self = [super init];
    if (self) {
        SMRequestQueue *queue = [SMRequestQueue shareInstance];
        self.queue = queue;
        
        JokeAPI *api = [[JokeAPI alloc] initWithDelegate:self finishedSelector:@selector(finishedAction:) faildSelector:@selector(faildAtion:)];
        self.api = api;
        
        JokeDao *dao = [[JokeDao alloc] init];
        self.dao = dao;
    }
    return self;
}

#pragma mark - request
- (void)requestJokeListWithCurPage:(int)curPage {
    SMUrlRequest *request = [self.api requestJokeList];
    request.key = kRequestJokeList;
    request.page = curPage;
    [self addRequest:request useCache:YES useQueue:YES];
}

#pragma mark - db option
- (void)makeJokeReadWithId:(NSString *)xhid {
    SMJoke *joke = [self.dao searchJokesWithId:xhid].firstObject;
    if (joke) {
        joke.isRead = YES;
        [self.dao updateJoke:joke];
    } else {
        SMLog(@"joke uid:%@ 不存在", xhid);
    }
}

#pragma mark - request - responds
- (void)finishedAction:(SMUrlRequest *)request {
    if ([kRequestJokeList isEqualToString:request.key]) {
        SMResult *result = request.responseParserObject;
        int count = [self.dao insertJokes:result.detail];
        NSArray *detail = [[[self.dao searchJokes] reverseObjectEnumerator] allObjects];
        if ([self.delegate respondsToSelector:@selector(respondsJokeList:curPage:)]) {
            [self.delegate respondsJokeList:detail curPage:(count?request.page:1)];
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
    if ([kRequestJokeList isEqualToString:request.key]) {
        NSArray *detail = [[[self.dao searchJokes] reverseObjectEnumerator] allObjects];
        if ([self.delegate respondsToSelector:@selector(respondsJokeList:curPage:)]) {
            [self.delegate respondsJokeList:detail curPage:1];
        }
    }
}

@end
