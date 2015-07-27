//
//  AutoTableViewCell.h
//  Demo-AutoTableViewCell
//
//  Created by 丁治文 on 15/7/23.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoTableViewCell;
@protocol AutoTableViewCellProtocol <NSObject>

@optional
// for sub class realize
+ (CGRect)autoRectWithCell:(AutoTableViewCell *)cell;
- (void)autoRectWithDrawRect:(CGRect)rect;

@end

@interface AutoTableViewCell : UITableViewCell

// for sub class use, if you want to use the autoSize, you nust call it after setting values
- (void)setNeedLayoutWithAutoRect;
- (void)setNeedLayoutWithAutoRectWithDrawRect:(CGRect)rect;

// for other class use
+ (CGRect)autoRect;

// for sub/other class use
+ (CGRect)autoSizeWithLabel:(UILabel *)label;
+ (CGRect)autoSizeWithImage:(UIImage *)image;
+ (CGRect)autoSizeWithView:(UIView *)view; /**< 暂未实现 */

@end
