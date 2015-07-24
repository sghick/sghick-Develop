//
//  AutoRectUtil.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "AutoRectUtil.h"

@implementation AutoRectUtil

+ (CGRect)autoSizeWithLabel:(UILabel *)label {
    CGRect bounds = [UIScreen mainScreen].bounds;
    return [self autoSizeWithLabel:label forBounds:bounds];
}

+ (CGRect)autoSizeWithLabel:(UILabel *)label forBounds:(CGRect)bounds{
    CGRect rect = CGRectZero;
    rect = [label textRectForBounds:bounds limitedToNumberOfLines:label.numberOfLines];
    return rect;
}

+ (CGRect)autoSizeWithImage:(UIImage *)image {
    CGRect rect = CGRectZero;
    rect.size = image.size;
    return rect;
}

+ (CGRect)autoSizeWithView:(UIView *)view {
    CGRect rect = CGRectZero;
    rect = view.frame;
    return rect;
}

@end
