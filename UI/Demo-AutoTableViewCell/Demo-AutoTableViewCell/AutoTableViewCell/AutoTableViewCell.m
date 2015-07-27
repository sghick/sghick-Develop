//
//  AutoTableViewCell.m
//  Demo-AutoTableViewCell
//
//  Created by 丁治文 on 15/7/23.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "AutoTableViewCell.h"

@interface AutoTableViewCell ()<AutoTableViewCellProtocol>

@end

@implementation AutoTableViewCell

static AutoTableViewCell *_currentCell = nil;

+ (CGRect)autoRect {
    CGRect rect = CGRectZero;
    if (_currentCell && [_currentCell isKindOfClass:[self class]]) {
        rect = [self autoRectWithCell:_currentCell];
        [_currentCell setNeedLayoutWithAutoRectWithDrawRect:rect];
    }
    return rect;
}

- (void)setNeedLayoutWithAutoRect {
    _currentCell = self;
}

- (void)setNeedLayoutWithAutoRectWithDrawRect:(CGRect)rect {
    _currentCell = self;
    [self autoRectWithDrawRect:rect];
}

#pragma mark - AutoTableViewCellProtocol for sub class realize
+ (CGRect)autoRectWithCell:(AutoTableViewCell *)cell {
    // sub class realize
    return CGRectZero;
}

- (void)autoRectWithDrawRect:(CGRect)rect {
    // sub class realize
}


#pragma mark - () for sub/other class use
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
