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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    SMLog(@"setValueForUndefinedKey:%@ in %@", key, NSStringFromClass([self class]));
}

- (void)setValue:(id)value forKey:(NSString *)key {
    NSString *unKey = self.keysMapper[key];
    if (unKey) {
        [super setValue:value forKey:unKey];
    } else {
        @try {
            [super setValue:value forKey:key];
        }
        @catch (NSException *exception) {
            [self setValue:value forUndefinedKey:key];
        }
    }
}

- (NSString *)description{
    return SMToString(@"%@", self.dictionary);
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

- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper{
    [self setValuesWithDictionary:dict classNamesMapper:mapper keysMapper:nil];
}

- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper keysMapper:(NSDictionary *)keysMapper {
    if (_keysMapper != keysMapper) {
        _keysMapper = keysMapper;
    }
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
            [model setValuesWithDictionary:subDict classNamesMapper:curDict keysMapper:keysMapper];
            [subModel addObject:model];
        }
        [self setValue:subModel forKey:key];
    }
}

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper {
    return [self arrayWithDictionary:dict classNamesMapper:mapper keysMapper:nil];
}

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper keysMapper:(NSDictionary *)keysMapper {
    NSMutableArray * rtnArr = [[NSMutableArray alloc] initWithCapacity:0];
    Class mainClass = NSClassFromString([mapper objectForKey:parserReturnTypeMainArrayOfKey]);
    if (!mainClass) {
        SMLog(@"%@:未设置key:parserReturnTypeMainArrayOfKey的类名映射！", kLogWarming);
    }
    if ([dict isKindOfClass:[NSDictionary class]]) {
        for (NSString * key in mapper.allKeys) {
            if ([NSStringFromClass(mainClass) isEqualToString:[mapper objectForKey:key]]) {
                NSArray * arr = [dict objectForKey:key];
                NSMutableDictionary * curDict = [[NSMutableDictionary alloc] initWithDictionary:mapper];
                [curDict removeObjectForKey:parserReturnTypeMainArrayOfKey];
                [curDict removeObjectForKey:key];
                for (NSDictionary * subDict in arr) {
                    SMModel * model = [[mainClass alloc] init];
                    [model setValuesWithDictionary:subDict classNamesMapper:curDict keysMapper:keysMapper];
                    [rtnArr addObject:model];
                }
            }
        }
    } else if ([dict isKindOfClass:[NSArray class]]) {
        for (NSDictionary *subDict in dict) {
            SMModel * model = [[mainClass alloc] init];
            [model setValuesWithDictionary:subDict classNamesMapper:mapper keysMapper:keysMapper];
            [rtnArr addObject:model];
        }
    } else {
        SMLog(@"错误：数据源是字典和数组以外的类型！");
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
