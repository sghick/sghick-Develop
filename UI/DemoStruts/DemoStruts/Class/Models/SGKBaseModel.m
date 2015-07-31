//
//  SGKBaseModel.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/2.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKBaseModel.h"
#import <objc/runtime.h>

@implementation SGKBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    SpLog(@"setValueForUndefinedKey:%@ in %@", key, NSStringFromClass([self class]));
}

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


- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper{
    [self setValuesForKeysWithDictionary:dict];
    if (!mapper) {
        return;
    }
    NSArray * keys = mapper.allKeys;
    for (NSString * key in keys) {
        NSString * property = [mapper objectForKey:key];
        NSArray * arr = [dict objectForKey:property];
        NSMutableDictionary * curDict = [[NSMutableDictionary alloc] initWithDictionary:mapper];
        [curDict removeObjectForKey:key];
        NSMutableArray * subModel = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary * subDict in arr) {
            Class modelClass = NSClassFromString(key);
            SGKBaseModel * model = [[modelClass alloc] init];
            [model setValuesWithDictionary:subDict classNamesMapper:curDict];
            [subModel addObject:model];
        }
        [self setValue:subModel forKey:property];
    }
}

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper{
    NSMutableArray * rtnArr = [[NSMutableArray alloc] initWithCapacity:0];
    Class modelClass = [self class];
    NSString * property = [mapper objectForKey:NSStringFromClass(modelClass)];
    NSArray * arr = [dict objectForKey:property];
    NSMutableDictionary * curDict = [[NSMutableDictionary alloc] initWithDictionary:mapper];
    [curDict removeObjectForKey:NSStringFromClass(modelClass)];
    for (NSDictionary * subDict in arr) {
        SGKBaseModel * model = [[modelClass alloc] init];
        [model setValuesWithDictionary:subDict classNamesMapper:curDict];
        [rtnArr addObject:model];
    }
    return rtnArr;
}

@end
