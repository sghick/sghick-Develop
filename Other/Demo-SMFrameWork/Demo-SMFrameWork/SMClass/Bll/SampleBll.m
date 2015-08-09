//
//  SampleBll.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SampleBll.h"
#import "SampleDal.h"
#import "SMUrlRequest.h"
#import "SMResult.h"
#import "SMJoke.h"

@interface SampleBll () <
SampleDalDelegate
>

@property (strong, nonatomic) SampleDal *dal;

@end

@implementation SampleBll

- (instancetype)init {
    self = [super init];
    if (self) {
        SampleDal *dal = [[SampleDal alloc] init];
        dal.delegate = self;
        self.dal = dal;
    }
    return self;
}

#pragma mark - request
- (void)requestGetTestDataWithParam:(SMModel *)param {
    [self.dal requestGetTestDataWithParam:param];
}

- (void)requestPostTestDataWithParam:(SMModel *)param {
    [self.dal requestPostTestDataWithParam:param];
}

- (void)requestFileTestDataWithParam:(SMModel *)param {
    [self.dal requestFileTestDataWithParam:param];
}

#pragma mark - dal delegate
- (void)respondsFaildWithUrlRequest:(SMUrlRequest *)request {
    if ([self.delegate respondsToSelector:@selector(respondsFaildWithErrorCode:)]) {
        [self.delegate respondsFaildWithErrorCode:request.responseErrorCode];
    }
}

- (void)respondsGetWithUrlRequest:(SMUrlRequest *)request {
    SMResult *result = request.responseParserObject;
    NSArray *dataSource = result.detail;
    if ([self.delegate respondsToSelector:@selector(respondsGetTestData:)]) {
        [self.delegate respondsGetTestData:dataSource];
    }
}

- (void)respondsPostWithUrlRequest:(SMUrlRequest *)request {
    if ([self.delegate respondsToSelector:@selector(respondsPostTestData:)]) {
        [self.delegate respondsPostTestData:request.responseParserObject];
    }
}

- (void)respondsFileWithUrlRequest:(SMUrlRequest *)request {
    if ([self.delegate respondsToSelector:@selector(respondsFileTestData:)]) {
        [self.delegate respondsFileTestData:request.responseParserObject];
    }
}

@end
