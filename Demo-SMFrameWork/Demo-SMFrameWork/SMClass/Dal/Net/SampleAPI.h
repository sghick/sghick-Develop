//
//  SampleAPI.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMAPI.h"

@class SMModel;
@interface SampleAPI : SMAPI

- (SMUrlRequest *)requestGetTestWithParam:(SMModel *)param;

- (SMUrlRequest *)requestPostTestWithParam:(SMModel *)param;

- (SMUrlRequest *)requestFILETestWithParam:(SMModel *)param;

@end
