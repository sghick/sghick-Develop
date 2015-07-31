//
//  SGKBaseModel.h
//  DemoStruts
//
//  Created by 丁治文 on 15/1/2.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGKBaseModel : NSObject

- (NSDictionary *)dictionary;

- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;

@end
