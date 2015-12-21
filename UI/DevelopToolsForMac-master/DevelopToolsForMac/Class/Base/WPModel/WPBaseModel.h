//
//  WPBaseModel.h
//  WisdomPark
//
//  Created by 丁治文 on 15/1/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * parserReturnTypeMainModelOfKey = @"__parserReturnTypeMainModelOfKey__";
static NSString * parserReturnTypeMainArrayOfKey = @"__parserReturnTypeMainArrayOfKey__";

@interface WPBaseModel : NSObject

/**
 *  返回一个字典对象
 *
 *  @return 一个字典对象
 */
- (NSDictionary *)dictionary;

/**
 *  设置model对象
 *
 *  @param dict   要设置的值
 *  @param mapper 映射
 */
- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;

/**
 *  设置并返回一个数组
 *
 *  @param dict   要设置的值
 *  @param mapper 映射
 *
 *  @return 数组
 */
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;

/**
 *  将字典中的value转成NSString类型
 */
+ (NSDictionary *)dictionaryFormateToString:(NSDictionary *)dict;

@end
