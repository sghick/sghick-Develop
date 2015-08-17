//
//  SampleBll.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMModel;
@protocol SampleBllDelegate <NSObject>

- (void)respondsFaildWithErrorCode:(NSString *)errorCode;

- (void)respondsGetTestData:(NSArray *)array;
- (void)respondsPostTestData:(NSArray *)array;
- (void)respondsFileTestData:(NSArray *)array;
- (void)respondsLocalTestData:(NSArray *)array;

@end

@interface SampleBll : SMBll

- (void)requestGetTestDataWithParam:(SMModel *)param;
- (void)requestPostTestDataWithParam:(SMModel *)param;
- (void)requestFileTestDataWithParam:(SMModel *)param;
- (void)requestLocalTestData;

@end
