//
//  UIView+AutoRect.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "UIView+AutoRect.h"

@implementation UIView (AutoRect)

static UIView *_curView;

+ (CGRect)ar_autoRect {
    if (_curView && [_curView isKindOfClass:[self class]]) {
        _curView.frame = [_curView ar_layoutSuperView];
        [_curView ar_drawRect:_curView.frame];
        return _curView.frame;
    }
    if ([self isSubclassOfClass:[UITableViewCell class]]) {
        return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    }
    return CGRectZero;
}

- (void)ar_setNeedsLayout {
    _curView = self;
}

- (void)ar_setNeedsLayoutWithDrawRect:(CGRect)rect {
    _curView = self;
    [self ar_drawRect:rect];
}

- (void)ar_drawRect:(CGRect)rect {
    // for sub class realize
}

- (CGRect)ar_layoutSuperView {
    // for sub class realize
    return CGRectZero;
}

@end
