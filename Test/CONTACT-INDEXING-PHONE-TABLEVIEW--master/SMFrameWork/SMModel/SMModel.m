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

- (NSString *)description{
    return SMToString(@"%@", self.dictionary);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%s:%@", __func__, key);
}

- (NSDictionary *)dictionary{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSString *key in self.allKeys) {
        [dict setValue:[self valueForKey:key] forKey:key];
    }
    return dict;
}

- (NSArray *)allKeys {
    if (!_allKeys) {
        NSMutableArray * keys = [[NSMutableArray alloc] initWithCapacity:0];
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
            [keys addObject:attributeName];
        }
        free(properties);
        _allKeys = keys;
    }
    return _allKeys;
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
        id object = [dict objectForKey:key];
        if (!object) {
            continue;
        }
        NSMutableDictionary * curDict = [NSMutableDictionary dictionaryWithDictionary:mapper];
        [curDict removeObjectForKey:key];
        if ([object isKindOfClass:[NSArray class]]) {
            NSMutableArray * subModel = [NSMutableArray array];
            for (NSDictionary * subDict in object) {
                Class modelClass = NSClassFromString(mClass);
                SMModel * model = [[modelClass alloc] init];
                [curDict addEntriesFromDictionary:[modelClass classNameMapper]];
                [model setValuesWithDictionary:subDict classNamesMapper:curDict];
                [subModel addObject:model];
            }
            [self setValue:subModel forKey:key];
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            Class modelClass = NSClassFromString(mClass);
            SMModel * model = [[modelClass alloc] init];
            [curDict addEntriesFromDictionary:[modelClass classNameMapper]];
            [model setValuesWithDictionary:object classNamesMapper:curDict];
            [self setValue:model forKey:key];
        } else {
            NSLog(@"错误：数据源是字典和数组以外的类型！");
        }
    }
}

// (private)
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper {
    NSMutableArray * rtnArr = [NSMutableArray array];
    Class mainClass = NSClassFromString([mapper objectForKey:parserReturnTypeMainArrayOfKey]);
    if (!mainClass) {
        SMLog(@"%@:未设置key:parserReturnTypeMainArrayOfKey的类名映射！", kLogWarming);
    }
    if ([dict isKindOfClass:[NSArray class]]) {
        for (NSDictionary *subDict in dict) {
            SMModel * model = [[mainClass alloc] init];
            [model setValuesWithDictionary:subDict classNamesMapper:mapper];
            [rtnArr addObject:model];
        }
    } else {
        SMLog(@"错误：数据源是数组以外的类型！");
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
            [rtn setValue:SMToString(@"%@", value) forKey:key];
        }
    }
    return rtn;
}

+ (instancetype)instanceWithDictionary:(NSDictionary *)dict {
    return [self instanceWithDictionary:dict key:nil];
}

+ (instancetype)instanceWithDictionary:(NSDictionary *)dict key:(NSString *)key {
    NSDictionary *mapper = [self instanceClassNameMapper];
    NSDictionary *realDict = key?dict[key]:key;
    SMModel *instance = [[self alloc] init];
    [instance setValuesWithDictionary:realDict classNamesMapper:mapper];
    return instance;
}

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict {
    NSString *realKey = nil;
    for (NSString *key in dict.allKeys) {
        if ([dict[key] isKindOfClass:[NSArray class]]) {
            realKey = key;
            break;
        }
    }
    return [self arrayWithDictionary:dict key:realKey];
}

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict key:(NSString *)key {
    NSDictionary *mapper = [self arrayClassNameMapper];
    NSDictionary *realDict = key?dict[key]:key;
    return [self arrayWithDictionary:realDict classNamesMapper:mapper];
}

+ (NSMutableDictionary *)instanceClassNameMapper {
    NSMutableDictionary *classMapper = [self classNameMapper];
    [classMapper setObject:NSStringFromClass([self class]) forKey:parserReturnTypeMainModelOfKey];
    return classMapper;
}

+ (NSMutableDictionary *)arrayClassNameMapper {
    NSMutableDictionary *classMapper = [self classNameMapper];
    [classMapper setObject:NSStringFromClass([self class]) forKey:parserReturnTypeMainArrayOfKey];
    return classMapper;
}

+ (NSMutableDictionary *)classNameMapper {
    return [NSMutableDictionary dictionary];
}

#pragma mark - 归档
- (NSData *)data {
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

+ (NSData *)dataFromModel:(SMModel *)model {
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    return data;
}

+ (instancetype)modelFromData:(NSData *)data {
    SMModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    NSDictionary *dict = self.dictionary;
    for (NSString *key in dict.allKeys) {
        [aCoder encodeObject:dict[key] forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder{;
    for (NSString *key in self.allKeys) {
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    return self;
}

@end
