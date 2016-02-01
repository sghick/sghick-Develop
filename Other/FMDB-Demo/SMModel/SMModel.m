//
//  SMModel.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMModel.h"
#import "SMLog.h"
#import <objc/runtime.h>

@implementation SMModel

- (id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"getUndifineKey:%@ in %@", key, NSStringFromClass([self class]));
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"setValueForUndefinedKey:%@ in %@", key, NSStringFromClass([self class]));
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@", self.dictionary];
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

- (void)setValuesWithDictionary:(NSDictionary *)dict {
    NSDictionary *mapper = [[self class] mappers];
    [self setValuesWithDictionary:dict classNamesMapper:mapper];
}

// (private)
- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper {
    NSDictionary * newDict = [SMModel dictionaryFormateToString:dict];
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
            SMModel * model = [[modelClass alloc] init];
            [model setValuesWithDictionary:subDict classNamesMapper:curDict];
            [subModel addObject:model];
        }
        [self setValue:subModel forKey:key];
    }
}

+ (NSArray *)arrayWithArrDictionary:(NSArray *)arrDict {
    NSDictionary *mapper = [self arrayMappers];
    return [self arrayWithDictionary:arrDict classNamesMapper:mapper];
}

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict arrayKey:(NSString *)arrayKey {
    NSDictionary *mapper = [self arrayMappers];
    NSArray *dictArr = [dict objectForKey:arrayKey];
    return [self arrayWithDictionary:dictArr classNamesMapper:mapper];
}

// (private)
+ (NSArray *)arrayWithDictionary:(id)dict classNamesMapper:(NSDictionary *)mapper{
    NSMutableArray * rtnArr = [[NSMutableArray alloc] initWithCapacity:0];
    Class mainClass = NSClassFromString([mapper objectForKey:parserReturnTypeMainArrayOfKey]);
    if (!mainClass) {
        NSLog(@"未设置key:parserReturnTypeMainArrayOfKey的类名映射！");
    }
    if ([dict isKindOfClass:[NSArray class]]) {
        for (NSDictionary * subDict in dict) {
            SMModel * model = [[mainClass alloc] init];
            [model setValuesWithDictionary:subDict classNamesMapper:mapper];
            [rtnArr addObject:model];
        }
    } else if ([dict isKindOfClass:[NSArray class]]) {
        for (NSString * key in mapper.allKeys) {
            if ([NSStringFromClass(mainClass) isEqualToString:[mapper objectForKey:key]]) {
                NSArray * arr = [dict objectForKey:key];
                NSMutableDictionary * curDict = [[NSMutableDictionary alloc] initWithDictionary:mapper];
                [curDict removeObjectForKey:parserReturnTypeMainArrayOfKey];
                [curDict removeObjectForKey:key];
                for (NSDictionary * subDict in arr) {
                    SMModel * model = [[mainClass alloc] init];
                    [model setValuesWithDictionary:subDict classNamesMapper:curDict];
                    [rtnArr addObject:model];
                }
            }
        }
    } else {
        NSLog(@"%@类型暂时无法处理", [NSArray class]);
    }
    return rtnArr;
}

+ (NSDictionary *)dictionaryFormateToString:(NSDictionary *)dict{
    NSMutableDictionary * rtn = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSArray * keys = [dict allKeys];
    for (NSString * key in keys) {
        id value = [dict objectForKey:key];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            // 什么也不做
        }
        else{
            [rtn setValue:[NSString stringWithFormat:@"%@", value] forKey:key];
        }
    }
    return rtn;
}

+ (NSMutableDictionary *)mappers {
    NSMutableDictionary *mps = [NSMutableDictionary dictionary];
    [mps setObject:NSStringFromClass([self class]) forKey:parserReturnTypeMainModelOfKey];
    return mps;
}

+ (NSMutableDictionary *)arrayMappers {
    NSMutableDictionary *mps = [NSMutableDictionary dictionary];
    [mps setObject:NSStringFromClass([self class]) forKey:parserReturnTypeMainArrayOfKey];
    return mps;
}

@end
