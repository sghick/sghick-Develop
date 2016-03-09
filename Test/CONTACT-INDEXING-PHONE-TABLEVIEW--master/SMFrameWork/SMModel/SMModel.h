//
//  SMModel.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+SMModel.h"

static NSString * parserReturnTypeMainModelOfKey = @"__parserReturnTypeMainModelOfKey__";
static NSString * parserReturnTypeMainArrayOfKey = @"__parserReturnTypeMainArrayOfKey__";

@interface SMModel : NSObject <
    NSCoding
>

@property (strong, nonatomic) NSArray *allKeys;

- (NSDictionary *)dictionary;
+ (NSDictionary *)dictionaryFormateToString:(NSDictionary *)dict;

+ (instancetype)instanceWithDictionary:(NSDictionary *)dict;
+ (instancetype)instanceWithDictionary:(NSDictionary *)dict key:(NSString *)key;
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict;
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict key:(NSString *)key;

// 如果要转换的属性对象在本类中为自定义对象类型,使用此方法
+ (NSMutableDictionary *)instanceClassNameMapper;
// 如果要转换的属性对象在本类中为数组类型,使用此方法
+ (NSMutableDictionary *)arrayClassNameMapper;
// override for sub class
+ (NSMutableDictionary *)classNameMapper;

#pragma mark - 归档
- (NSData *)data;
+ (NSData *)dataFromModel:(SMModel *)model;
+ (instancetype)modelFromData:(NSData *)data;

@end
