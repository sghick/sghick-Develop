//
//  SGKAccording.m
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import "SGKAccording.h"

@implementation SGKAccording

@synthesize view = _view;
@synthesize frame = _frame;

// 初始化方法
- (id)initWithView:(UIView *)view frame:(CGRect)frame{
    self = [super init];
    if (self) {
        _view = view;
        _frame = frame;
    }
    return self;
}

// 判断本参照和某一参照的视图是否相同
- (BOOL)isEqualToAccording:(SGKAccording *)according{
    if (self.view == according.view) {
        return YES;
    }
    return NO;
}

// 判断本参照是否存在数组中
- (BOOL)isExsitInArray:(NSArray *)array{
    for (SGKAccording * accor in array) {
        if ([self isEqualToAccording:accor]) {
            return YES;
        }
    }
    return NO;
}

// 取出数组中不重复的参照
+ (NSArray *)accordingsWithNoRepeat:(NSArray *)array{
    NSMutableArray * rtnAccordings = [[NSMutableArray alloc] initWithCapacity:0];
    for (SGKAccording * accor in array) {
        if (![accor isExsitInArray:rtnAccordings]) {
            [rtnAccordings addObject:accor];
        }
    }
    return rtnAccordings;
}

#pragma mark- NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.view forKey:@"view"];
    [aCoder encodeCGRect:self.frame forKey:@"frame"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self.view = [aDecoder decodeObjectForKey:@"view"];
    self.frame = [aDecoder decodeCGRectForKey:@"frame"];
    return self;
}

@end
