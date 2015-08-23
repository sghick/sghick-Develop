//
//  UIView+SMAttributies.h
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(int32_t, SMNetLineType) {
    SMNetLineTypeDefault        = 0xFFFF,   /*< -1 */
    SMNetLineTypeNone           = 0,        /*< 0 */
    SMNetLineTypeUseStatusBar   = 1 << 0,   /*< 1 */
    SMNetLineTypeUseNavBar      = 1 << 1,   /*< 2 */
    SMNetLineTypeUseTabBar      = 1 << 2,   /*< 4 */
    
    SMNetLineTypeShowNumber     = 32 << 0   /*< 32 */
};

@interface UIView (SMAttributies)

- (void)addSubview:(nonnull UIView *)view attributePathKey:(nonnull NSString *)pathKey;
- (CGSize)sizeWithConstraints;
- (void)showNetLineWithRowAndColoum:(CGPoint)rowAndColoum lineColor:(nonnull UIColor *)lineColor netType:(SMNetLineType)netType alpha:(CGFloat)alpha;

@end
