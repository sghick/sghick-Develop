//
//  UIViewController+WP.m
//  WisdomPark
//
//  Created by 丁治文 on 15/4/17.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "UIViewController+WP.h"

@implementation UIViewController (WP)

- (void)setBackBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    UIImage * backImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = backImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage;
}

@end
