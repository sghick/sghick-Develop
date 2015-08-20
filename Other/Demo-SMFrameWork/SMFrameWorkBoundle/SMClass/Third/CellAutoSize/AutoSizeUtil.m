//
//  AutoSizeUtil.m
//  Demo-AutoTableViewCell
//
//  Created by buding on 15/7/28.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "AutoSizeUtil.h"

@implementation AutoSizeUtil

+ (CGRect)autoSizeWithLabel:(UILabel *)label {
    CGRect bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, MAXFLOAT);
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

+ (CGRect)autoSizeWithTextView:(UITextView *)textView {
    CGRect rect = CGRectZero;
    rect = textView.frame;
    return rect;
}

+ (CGRect)autoLayoutSizeWithView:(UIView *)view {
    CGRect rect = CGRectZero;
    rect.size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return rect;
}

+ (CGRect)autoLayoutSizeWithTableViewCell:(UITableViewCell *)cell {
    CGRect rect = CGRectZero;
    rect.size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    rect.size.height += 1;
    return rect;
}

@end
