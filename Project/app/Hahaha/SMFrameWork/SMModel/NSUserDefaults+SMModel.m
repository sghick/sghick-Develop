//
//  NSUserDefaults+SMModel.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "NSUserDefaults+SMModel.h"
#import "SMModel.h"

@implementation NSUserDefaults (SMModel)

- (void)setModel:(SMModel *)model forKey:(NSString *)key {
    [self setValue:model.data forKey:key];
}

- (id)modelForKey:(NSString *)key {
    NSData *data = [self objectForKey:key];
    SMModel *model = [SMModel modelFromData:data];
    return model;
}

@end
