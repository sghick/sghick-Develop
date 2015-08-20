//
//  WPBaseModel.m
//  WisdomPark
//
//  Created by 丁治文 on 15/1/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBaseModel.h"
#import <objc/runtime.h>

@implementation WPBaseModel

- (id)valueForUndefinedKey:(NSString *)key{
    WpDebugLog(@"getUndifineKey:%@ in %@", key, NSStringFromClass([self class]));
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    WpDebugLog(@"setValueForUndefinedKey:%@ in %@", key, NSStringFromClass([self class]));
}

- (NSString *)description{
    return WpToString(@"%@", self.dictionary);
}

/**
 *  返回一个字典对象
 *
 *  @return 一个字典对象
 */
- (NSDictionary *)dictionary{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    id classM = objc_getClass([NSStringFromClass([self class]) UTF8String]);
    // i 计数 、  outCount 放我们的属性个数
    unsigned int outCount, i;
    // 反射得到属性的个数
    objc_property_t * properties = class_copyPropertyList(classM, &outCount);
    // 循环 得到属性名称
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        // 获得属性名称
        NSString * attributeName = [NSString stringWithUTF8String:property_getName(property)];
        [dict setValue:[self valueForKey:attributeName] forKey:attributeName];
    }
    free(properties);
    return dict;
}

/**
 *  设置model对象
 *
 *  @param dict   要设置的值
 *  @param mapper 映射
 */
- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper{
    NSDictionary * newDict = [WPBaseModel dictionaryFormateToString:dict];
    [self setValuesForKeysWithDictionary:newDict];
    if (!mapper) {
        return;
    }
    NSMutableArray * keys = [NSMutableArray arrayWithArray:mapper.allKeys];
    [keys removeObject:parserReturnTypeMainArrayOfKey];
    [keys removeObject:parserReturnTypeMainModelOfKey];
    for (NSString * key in keys) {
        NSString * mClass = [mapper objectForKey:key];
        NSArray * arr = [dict objectForKey:key];
        NSMutableDictionary * curDict = [[NSMutableDictionary alloc] initWithDictionary:mapper];
        [curDict removeObjectForKey:key];
        NSMutableArray * subModel = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary * subDict in arr) {
            Class modelClass = NSClassFromString(mClass);
            WPBaseModel * model = [[modelClass alloc] init];
            [model setValuesWithDictionary:subDict classNamesMapper:curDict];
            [subModel addObject:model];
        }
        [self setValue:subModel forKey:key];
    }
}

/**
 *  设置并返回一个数组
 *
 *  @param dict   要设置的值
 *  @param mapper 映射
 *
 *  @return 数组
 */
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper{
    NSMutableArray * rtnArr = [[NSMutableArray alloc] initWithCapacity:0];
    Class mainClass = NSClassFromString([mapper objectForKey:parserReturnTypeMainArrayOfKey]);
    if (!mainClass) {
        WpWarmLog(@"未设置key:parserReturnTypeMainArrayOfKey的类名映射！");
    }
    for (NSString * key in mapper.allKeys) {
        if ([NSStringFromClass(mainClass) isEqualToString:[mapper objectForKey:key]]) {
            NSArray * arr = [dict objectForKey:key];
            NSMutableDictionary * curDict = [[NSMutableDictionary alloc] initWithDictionary:mapper];
            [curDict removeObjectForKey:parserReturnTypeMainArrayOfKey];
            [curDict removeObjectForKey:key];
            for (NSDictionary * subDict in arr) {
                WPBaseModel * model = [[mainClass alloc] init];
                [model setValuesWithDictionary:subDict classNamesMapper:curDict];
                [rtnArr addObject:model];
            }
        }
    }
    return rtnArr;
}

/**
 *  将字典中的value转成NSString类型
 */
+ (NSDictionary *)dictionaryFormateToString:(NSDictionary *)dict{
    NSMutableDictionary * rtn = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSArray * keys = [dict allKeys];
    for (NSString * key in keys) {
        id value = [dict objectForKey:key];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            // 什么也不做
        }
        else{
            [rtn setValue:WpToString(@"%@", value) forKey:key];
        }
    }
    return rtn;
}

@end
