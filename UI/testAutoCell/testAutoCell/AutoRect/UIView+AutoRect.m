//
//  UIView+AutoRect.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "UIView+AutoRect.h"

#define defaultCellRect CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)

@implementation UIView (AutoRect)

static UIView *_curView;

+ (CGRect)ar_autoRect {
    if (_curView && [_curView isKindOfClass:[self class]]) {
        CGRect rect = [_curView ar_layoutSuperView];
        if (CGRectIsEmpty(rect)) {
            if ([self isSubclassOfClass:[UITableViewCell class]]) {
                rect.size = [((UITableViewCell *)_curView).contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
                rect.size.height += 1;
            }
            else {
                rect.size = [_curView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            }
        }
        [_curView updateConstraintsIfNeeded];
        [_curView ar_updateConstraints];
        [_curView ar_drawRect:_curView.frame];
        return _curView.frame;
    }
    if ([self isSubclassOfClass:[UITableViewCell class]]) {
        return defaultCellRect;
    }
    return CGRectZero;
}

+ (CGFloat)ar_autoHeight {
    return self.ar_autoRect.size.height;
}

- (void)ar_setNeedsLayout {
    _curView = self;
}

- (void)ar_setNeedsLayoutWithDrawRect:(CGRect)rect {
    _curView = self;
    [self ar_drawRect:rect];
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
