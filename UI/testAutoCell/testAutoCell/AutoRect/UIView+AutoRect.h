//
//  UIView+AutoRect.h
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewAutoRectProtocol <NSObject>

// for sub class realize
@required
- (void)ar_drawRect:(CGRect)rect;
- (CGRect)ar_layoutSuperView;

@end

@interface UIView (AutoRect)<UIViewAutoRectProtocol>
// for other class use
+ (CGRect)ar_autoRect;

// for sub class use
- (void)ar_setNeedsLayout;
- (void)ar_setNeedsLayoutWithDrawRect:(CGRect)rect;

@end
