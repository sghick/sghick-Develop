//
//  SampleDal.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SampleDal.h"
#import "SMModel.h"
#import "SMNetManager.h"
#import "SMUrlRequest.h"
#import "SampleAPI.h"

@interface SampleDal ()

@property (strong, nonatomic) SampleAPI *api;

@end

@implementation SampleDal

- (instancetype)init {
    self = [super init];
    if (self) {
        SampleAPI *api = [[SampleAPI alloc] initWithDelegate:self finishedSelector:@selector(finishedAction:) faildSelector:@selector(faildAtion:)];
        self.api = api;
    }
    return self;
}

#pragma mark - request
- (void)requestGetTestDataWithParam:(SMModel *)param {
    SMUrlRequest *request = [self.api requestGetTestWithParam:param];
    request.key = @"requestGetTestData";
    [SMNetManager addRequest:request];
}

- (void)requestPostTestDataWithParam:(SMModel *)param {
    SMUrlRequest *request = [self.api requestPostTestWithParam:param];
    request.key = @"requestPostTestData";
    [SMNetManager addRequest:request];
}

- (void)requestFileTestDataWithParam:(SMModel *)param {
    SMUrlRequest *request = [self.api requestFILETestWithParam:param];
    request.key = @"requestFileTestData";
    [SMNetManager addRequest:request];
}

#pragma mark - responds
- (void)finishedAction:(SMUrlRequest *)request {
    if ([@"requestGetTestData" isEqualToString:request.key]) {
        if ([self.delegate respondsToSelector:@selector(respondsGetWithUrlRequest:)]) {
            [self.delegate respondsGetWithUrlRequest:request];
        }
    } else if ([@"requestPostTestData" isEqualToString:request.key]) {
        if ([self.delegate respondsToSelector:@selector(respondsPostWithUrlRequest:)]) {
            [self.delegate respondsPostWithUrlRequest:request];
        }
    } else if ([@"requestFileTestData" isEqualToString:request.key]) {
        if ([self.delegate respondsToSelector:@selector(respondsFileWithUrlRequest:)]) {
            [self.delegate respondsFileWithUrlRequest:request];
        }
    }
}

- (void)faildAtion:(SMUrlRequest *)request {
    if ([self.delegate respondsToSelector:@selector(respondsFaildWithUrlRequest:)]) {
        [self.delegate respondsFaildWithUrlRequest:request];
    }
}

@end
