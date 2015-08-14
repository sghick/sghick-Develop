//
//  UITableViewCell+AutoSize.h
//  testAutoCell
//
//  Created by buding on 15/7/27.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultCellRect CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)

@protocol UITableViewCellAutoSizeProtocol <NSObject>
// for sub class realize
@required
- (CGRect)ar_layoutSuperView;       /**< 更新cell的frame */

@optional
- (void)ar_drawRect:(CGRect)rect;   /**< 设置subviews的布局, 设置了自动约束之后在此设置的frame自动失效 */
- (void)ar_updateConstraints;       /**< 设置自动约束，也可以写在updateConstraints中 请务必要设置Label的最大宽值*/

@end

@interface UITableViewCell (AutoSize)

// for other class use
- (void)ar_setNeedsLayoutWithIndexPath:(NSIndexPath *)indexPath;                            /**< 在cell的空间分配后调用 */
+ (void)ar_setNeedsLayoutCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;   /**< 在cell的空间分配后调用 */

+ (UITableViewCell *)ar_cellForIndexPath:(NSIndexPath *)indexPath;                          /**< 取出当前的cell */
+ (CGRect)ar_autoRectForCell:(UITableViewCell *)cell;                                       /**< 获取自动计算后的cell的frame */
+ (CGFloat)ar_autoHeightForCell:(UITableViewCell *)cell;                                    /**< 获取自动高 */
+ (CGFloat)ar_autoHeightForRowIndexPath:(NSIndexPath *)indexPath;                           /**< 获取自动高 */

@end
