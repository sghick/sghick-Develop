//
//  SGKAccording.h
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGKAccording : NSObject<NSCoding>

// 参照视图
@property (strong, nonatomic) UIView * view;
// 参照视图的frame
@property (assign, nonatomic) CGRect frame;

// 初始化方法
- (id)initWithView:(UIView *)view frame:(CGRect)frame;

// 判断本参照和某一参照的视图是否相同
- (BOOL)isEqualToAccording:(SGKAccording *)according;

// 判断本参照是否存在数组中
- (BOOL)isExsitInArray:(NSArray *)array;

// 取出数组中不重复的参照
+ (NSArray *)accordingsWithNoRepeat:(NSArray *)array;

@end
