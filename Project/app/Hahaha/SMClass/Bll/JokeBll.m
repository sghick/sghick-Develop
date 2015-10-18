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

static NSString *kRequestJokeList1 = @"kRequestJokeList1";
static NSString *kRequestJokeList2 = @"kRequestJokeList2";
static NSString *kRequestJokeList3 = @"kRequestJokeList3";
static NSString *kRequestJokeListInBackground1 = @"kRequestJokeListInBackground1";

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

#pragma mark - request - responds
- (void)finishedAction:(SMUrlRequest *)request {
    if ([kRequestJokeList1 isEqualToString:request.key]) {
        SMResult *result = request.responseParserObject;
        int count = [self.dao insertJokes:result.detail];
        SMLog(@"请求到%zi条, 新增数据%d条",result.detail.count, count);
        if ([self.delegate respondsToSelector:@selector(respondsJokesCount:curPage:)]) {
            [self.delegate respondsJokesCount:count curPage:request.page];
        }
    }
    if ([kRequestJokeListInBackground1 isEqualToString:request.key]) {
        SMResult *result = request.responseParserObject;
        int count = [self.dao insertJokes:result.detail];
        SMLog(@"请求到%zi条, 新增数据%d条",result.detail.count, count);
        if ([self.delegate respondsToSelector:@selector(respondsJokeListInBackgroundCount:curPage:)]) {
            [self.delegate respondsJokeListInBackgroundCount:count curPage:request.page];
        }
    }
//    if ([kRequestJokeList2 isEqualToString:request.key]) {
//        NSArray *results = request.responseParserObject;
//        for (SMJoke *joke in results) {
//            joke.xhid = [@"0" stringByAppendingString:[joke.title stringInitial]];
//        }
//        int count = [self.dao insertJokes:results];
//        SMLog(@"请求到%zi条, 新增数据%d条",results.count, count);
//        if ([self.delegate respondsToSelector:@selector(respondsJokesCount:curPage:)]) {
//            [self.delegate respondsJokesCount:count curPage:request.page];
//        }
//    }
}

- (void)faildAtion:(SMUrlRequest *)request {
    // 请求失败, 每个请求最多重试5次
    [self requestQueueWithTimesOut:5 cancelAllRequest:YES];
    if ([self.delegate respondsToSelector:@selector(respondsFaildWithErrorCode:)]) {
        [self.delegate respondsFaildWithErrorCode:request.responseErrorCode];
    }
}

#pragma mark - option
- (void)requestJokeListWithCurPage:(int)curPage {
    SMUrlRequest *request1 = [self.api requestJokeList1];
    request1.key = kRequestJokeList1;
    request1.page = curPage;
    [request1.paramsDict setObject:[NSString stringWithFormat:@"%d", curPage] forKey:@"page"];
    [self addRequest:request1 useQueue:YES];
    
//    SMUrlRequest *request2 = [self.api requestJokeList2];
//    request2.key = kRequestJokeList2;
//    request2.page = curPage;
//    [self addRequest:request2 useQueue:YES];
}

- (void)requestJokeListInBackgroundWithPage:(int)page toPage:(int)toPage {
    for (int i = page; i < toPage; i++) {
        SMUrlRequest *request1 = [self.api requestJokeList1];
        request1.key = kRequestJokeListInBackground1;
        request1.page = i;
        [request1.paramsDict setObject:[NSString stringWithFormat:@"%d", i] forKey:@"page"];
        [self addRequest:request1 useQueue:NO];
    }
}

- (void)makeJokeReadWithId:(NSString *)xhid {
    SMJoke *joke = [self.dao searchJokesWithId:xhid].firstObject;
    if (joke) {
        joke.isRead = YES;
        [self.dao updateJoke:joke];
    } else {
        SMLog(@"joke uid:%@ 不存在", xhid);
    }
}

- (NSArray *)searchJokesFromDBIsRead:(BOOL)isRead {
    return [self.dao searchJokesIsRead:isRead];
}

@end
