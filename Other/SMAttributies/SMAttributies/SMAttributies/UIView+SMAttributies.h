//
//  UIView+SMAttributies.h
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(int32_t, SMNetLineType) {
    SMNetLineTypeNone           = 0,        /*< 0 */
    SMNetLineTypeUseStatusBar   = 1 << 0,   /*< 1 */
    SMNetLineTypeUseNavBar      = 1 << 1,   /*< 2 */
    SMNetLineTypeUseTabBar      = 1 << 2,   /*< 4 */
    
    SMNetLineTypeAuto           = 16 << 0,  /*< 16 */
    
    SMNetLineTypeShowNumber     = 32 << 0   /*< 32 */
};

typedef NS_OPTIONS(int32_t, SMAutoAlign) {
    SMAutoAlignCenterX  = 1 << 1,
    SMAutoAlignCenterY  = 1 << 2,
    SMAutoAlignCenter   = SMAutoAlignCenterX & SMAutoAlignCenterY
};

typedef NS_ENUM(int32_t, SMAutoEdge) {
    SMAutoEdgeTop       = NSLayoutAttributeTop,
    SMAutoEdgeLeft      = NSLayoutAttributeLeft,
    SMAutoEdgeBottom    = NSLayoutAttributeBottom,
    SMAutoEdgeRight     = NSLayoutAttributeRight,
    SMAutoEdgeCenterX   = NSLayoutAttributeCenterX,
    SMAutoEdgeCenterY   = NSLayoutAttributeCenterY
};

typedef NS_ENUM(int32_t, SMAutoBounds) {
    SMAutoBoundsWidth   = NSLayoutAttributeWidth,
    SMAutoBoundsHeight  = NSLayoutAttributeHeight
};

@class SMPercentageFrame;
@interface UIView (SMAttributies)

#pragma mark - fileFrame
- (void)addSubview:(nonnull UIView *)view attributePathKey:(nonnull NSString *)pathKey;
- (void)fillView:(nonnull UIView *)view percentageFrame:(nonnull SMPercentageFrame *)percentageFrame pathKey:(nonnull NSString *)pathKey;
- (CGSize)sizeWithConstraints;
- (void)showNetLineWithRowAndColoum:(CGPoint)rowAndColoum lineColor:(nonnull UIColor *)lineColor netType:(SMNetLineType)netType alpha:(CGFloat)alpha;

- (void)addConstraintWithAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nullable UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;
@end
