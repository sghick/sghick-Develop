//
//  NSObject+SM.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "NSObject+SM.h"

@implementation NSObject (SM)

- (BOOL)isNullOrEmpty {
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary * value = (NSDictionary *)self;
        if (value.count == 0) {
            return YES;
        }
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        NSArray * value = (NSArray *)self;
        if (value.count == 0) {
            return YES;
        }
    }
    else if ([self isKindOfClass:[NSString class]]) {
        NSString * value = (NSString *)self;
        if ([value isEqualToString:@"<null>"]) {
            return YES;
        }
        if (value.length == 0) {
            return YES;
        }
    }
    return NO;
}

@end
