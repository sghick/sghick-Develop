//
//  UIView+SMAttributies.h
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SMAttributies)

- (void)addSubview:(nonnull UIView *)view attributePathKey:(nonnull NSString *)pathKey;
- (CGSize)sizeWithConstraints;
- (void)showNetLineWithRowAndColoum:(CGPoint)rowAndColoum lineColor:(nonnull UIColor *)lineColor showNumber:(BOOL)showNumber alpha:(CGFloat)alpha;

@end
