//
//  AutoTableViewCell.m
//  testAutoCell
//
//  Created by buding on 15/7/23.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "AutoTableViewCell.h"

@interface AutoTableViewCell ()<AutoTableViewCellProtocol>

@end

@implementation AutoTableViewCell

static AutoTableViewCell *_currentCell = nil;

- (void)setCell {
    _currentCell = self;
}

+ (instancetype)currentCell {
    return _currentCell;
}

+ (CGFloat)autoHeight {
    if (_currentCell && [_currentCell isKindOfClass:[self class]]) {
        return [self autoHeightWithCell:_currentCell];
    }
    return 0;
}

#pragma mark - AutoTableViewCellProtocol for sub class realize
+ (CGFloat)autoHeightWithCell:(AutoTableViewCell *)cell {
    return 0;
}

#pragma mark - () for sub/other class use
+ (CGSize)autoSizeWithLabel:(UILabel *)label {
    CGRect bounds = [UIScreen mainScreen].bounds;
    return [self autoSizeWithLabel:label forBounds:bounds];
}

+ (CGSize)autoSizeWithLabel:(UILabel *)label forBounds:(CGRect)bounds{
    CGRect rect = [label textRectForBounds:bounds limitedToNumberOfLines:label.numberOfLines];
    return rect.size;
}

+ (CGSize)autoSizeWithImage:(UIImage *)image {
    return image.size;
}

+ (CGSize)autoSizeWithView:(UIView *)view {
    return view.frame.size;
}

@end
