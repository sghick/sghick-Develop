//
//  WPBatches.h
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

// 批量生成Model
static NSString * const kbcModelCreate = @"WPBatchModelCreate";
// 批量生成Dal
static NSString * const kbcDalCreate = @"WPBatchDalCreate";
// 生成Json
static NSString * const kbcJsonCreate = @"WPBatchJsonCreate";

#import <Foundation/Foundation.h>

@interface WPBatches : NSObject

- (void)run:(NSString *)keyBatchClass;

@end
