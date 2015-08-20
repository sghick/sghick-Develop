//
//  UITableViewCell+AutoSize.m
//  testAutoCell
//
//  Created by buding on 15/7/27.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "UITableViewCell+AutoSize.h"

@implementation UITableViewCell (AutoSize)

static NSDictionary *_cellDict = nil;
- (void)ar_setNeedsLayoutWithIndexPath:(NSIndexPath *)indexPath {
    [UITableViewCell ar_setNeedsLayoutCell:self indexPath:indexPath];
}

+ (void)ar_setNeedsLayoutCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    _cellDict = @{indexPath:cell};
}

+ (UITableViewCell *)ar_cellForIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_cellDict objectForKey:indexPath];
    return cell;
}

+ (CGRect)ar_autoRectForCell:(UITableViewCell *)cell {
    if (cell && [cell isKindOfClass:[self class]]) {
        CGRect cellFrame = [cell ar_layoutSuperView];
        // 默认为自动约束
        [cell ar_updateConstraints];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        CGSize contentSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        if (!CGSizeEqualToSize(contentSize, CGSizeZero)) {
            cellFrame.size = contentSize;
            cellFrame.size.height += 1;
        } else {
            [cell ar_drawRect:cellFrame];
        }
        return cellFrame;
    }
    if ([self isSubclassOfClass:[UITableViewCell class]]) {
        return defaultCellRect;
    }
    return CGRectZero;
}

+ (CGFloat)ar_autoHeightForCell:(UITableViewCell *)cell {
    CGRect rect = [self ar_autoRectForCell:cell];
    return rect.size.height;
}

+ (CGFloat)ar_autoHeightForRowIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self ar_cellForIndexPath:indexPath];
    CGFloat height = [self ar_autoHeightForCell:cell];
    return height;
}

#pragma mark - for sub class realize
- (CGRect)ar_layoutSuperView {
    // for sub class realize
    return CGRectZero;
}

- (void)ar_drawRect:(CGRect)rect {
    // for sub class realize
}

- (void)ar_updateConstraints {
    // for sub class realize
}

@end
