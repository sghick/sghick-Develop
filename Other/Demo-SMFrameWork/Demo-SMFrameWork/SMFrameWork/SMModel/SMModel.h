//
//  SMModel.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#define parserReturnTypeMainModelOfKey      @"__parserReturnTypeMainModelOfKey__"
#define parserReturnTypeMainArrayOfKey      @"__parserReturnTypeMainArrayOfKey__"

#import <Foundation/Foundation.h>

@interface SMModel : NSObject

/** 返回一个字典对象 */
- (NSDictionary *)dictionary;

/** 设置model对象, 需要实现类方法+mappers */
- (void)setValuesWithDictionary:(NSDictionary *)dict;
/** 设置model对象 */
- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;

/** 设置并返回一个数组, 需要实现类方法+arrayMappers */
+ (NSArray *)arrayWithArrDictionary:(NSArray *)arrDict;
/** 设置并返回一个数组, 需要实现类方法+arrayMappers */
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict arrayKey:(NSString *)arrayKey ;
/** 设置并返回一个数组 */
+ (NSArray *)arrayWithDictionary:(id)dict classNamesMapper:(NSDictionary *)mapper;

/** 将字典中的value转成NSString类型  */
+ (NSDictionary *)dictionaryFormateToString:(NSDictionary *)dict;

/** 虚函数,子类实现,返回映射 */
+ (NSMutableDictionary *)mappers;
+ (NSMutableDictionary *)arrayMappers;

@end
