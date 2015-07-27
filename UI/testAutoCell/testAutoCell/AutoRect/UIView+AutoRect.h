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
- (CGRect)ar_layoutSuperView; /**< 更新cell的frame */

@optional
- (void)ar_drawRect:(CGRect)rect; /**< 设置subviews的布局, 设置了自动约束之后在此设置的frame自动失效 */
- (void)ar_updateConstraints; /**< 设置自动约束，也可以写在updateConstraints中 请务必要设置Label的最大宽值*/

@end

@interface UIView (AutoRect)<UIViewAutoRectProtocol>
// for other class use
+ (CGRect)ar_autoRect; /**< 获取自动计算后的cell的frame */
+ (CGFloat)ar_autoHeight; /**< 获取自动高 */

// for sub class use
- (void)ar_setNeedsLayout; /**< 在需要自动算高的view中使用 */

@end
