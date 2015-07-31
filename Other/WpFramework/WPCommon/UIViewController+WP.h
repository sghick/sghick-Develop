//
//  UIViewController+WP.h
//  WisdomPark
//
//  Created by 丁治文 on 15/4/17.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WP)

/**
 *  修改返回按钮
 *
 *  @param title 标题 为nil时表示显示默认标题，否则全显示title
 *  @param image 图片
 */
- (void)setBackBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image;

@end
