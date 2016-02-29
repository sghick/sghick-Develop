//
//  SMModel.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

static NSString * parserReturnTypeMainModelOfKey = @"__parserReturnTypeMainModelOfKey__";
static NSString * parserReturnTypeMainArrayOfKey = @"__parserReturnTypeMainArrayOfKey__";

#import <Foundation/Foundation.h>
#import "NSUserDefaults+SMModel.h"

@interface SMModel : NSObject <
NSCoding
>

@property (strong, nonatomic) NSArray *allKeys;
@property (strong, readonly, nonatomic) NSDictionary *keysMapper;

- (NSDictionary *)dictionary;

- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;
- (void)setValuesWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper keysMapper:(NSDictionary *)keysMapper;

+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper;
+ (NSArray *)arrayWithDictionary:(NSDictionary *)dict classNamesMapper:(NSDictionary *)mapper keysMapper:(NSDictionary *)keysMapper;

+ (NSDictionary *)dictionaryFormateToString:(NSDictionary *)dict;

#pragma mark - 归档
- (NSData *)data;
+ (NSData *)dataFromModel:(SMModel *)model;
+ (instancetype)modelFromData:(NSData *)data;

@end
