//
//  AutoSizeUtil.h
//  Demo-AutoTableViewCell
//
//  Created by buding on 15/7/28.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoSizeUtil : NSObject

+ (CGRect)autoSizeWithLabel:(UILabel *)label;
+ (CGRect)autoSizeWithLabel:(UILabel *)label forBounds:(CGRect)bounds;
+ (CGRect)autoSizeWithImage:(UIImage *)image;
+ (CGRect)autoSizeWithTextView:(UITextView *)textView;
+ (CGRect)autoLayoutSizeWithView:(UIView *)view;
+ (CGRect)autoLayoutSizeWithTableViewCell:(UITableViewCell *)cell;

@end
