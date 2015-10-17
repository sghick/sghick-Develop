//
//  SMResult.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMModel.h"
#import "SMTest.h"

@interface SMResult : SMModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSArray *detail;  /*< SMJoke */
@property (strong, nonatomic) SMTest *test;

@end
