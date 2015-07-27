//
//  AutoRectUtil.h
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoRectUtil : NSObject

+ (CGRect)autoSizeWithLabel:(UILabel *)label;
+ (CGRect)autoSizeWithLabel:(UILabel *)label forBounds:(CGRect)bounds;
+ (CGRect)autoSizeWithImage:(UIImage *)image;
+ (CGRect)autoSizeWithTextView:(UITextView *)textView;
+ (CGRect)autoLayoutSizeWithView:(UIView *)view;
+ (CGRect)autoLayoutSizeWithTableViewCell:(UITableViewCell *)cell;

@end
