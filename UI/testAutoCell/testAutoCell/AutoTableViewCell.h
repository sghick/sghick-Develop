//
//  AutoTableViewCell.h
//  testAutoCell
//
//  Created by buding on 15/7/23.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoTableViewCell;
@protocol AutoTableViewCellProtocol <NSObject>

// for sub class realize
+ (CGFloat)autoHeightWithCell:(AutoTableViewCell *)cell;

@end

@interface AutoTableViewCell : UITableViewCell

// for sub class use
- (void)setCell;
+ (instancetype)currentCell;

// for other class use
+ (CGFloat)autoHeight;

// for sub/other class use
+ (CGSize)autoSizeWithLabel:(UILabel *)label;
+ (CGSize)autoSizeWithImage:(UIImage *)image;
+ (CGSize)autoSizeWithView:(UIView *)view; /**< 暂未实现 */
@end
