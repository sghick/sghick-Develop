//
//  SampleDal.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMUrlRequest;
@protocol SampleDalDelegate <NSObject>

- (void)respondsFaildWithUrlRequest:(SMUrlRequest *)request;

- (void)respondsGetWithUrlRequest:(SMUrlRequest *)request;
- (void)respondsPostWithUrlRequest:(SMUrlRequest *)request;
- (void)respondsFileWithUrlRequest:(SMUrlRequest *)request;

@end

@class SMModel;
@interface SampleDal : SMDal

- (void)requestGetTestDataWithParam:(SMModel *)param;
- (void)requestPostTestDataWithParam:(SMModel *)param;
- (void)requestFileTestDataWithParam:(SMModel *)param;

@end
