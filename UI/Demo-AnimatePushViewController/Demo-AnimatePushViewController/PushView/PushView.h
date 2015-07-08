//
//  PushView.h
//  Demo-AnimatePushViewController
//
//  Created by dingzhiwen on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

// realize at sub class and used at presentedViewController
@protocol PushView <NSObject>

@optional
- (void)backToPresentingViewControllerWithTag:(int)tag;

@end

@interface PushView : UIView

// 动画时间，默认0.3f
@property (assign, nonatomic) NSTimeInterval animationDuration;

// use for sub class
- (void)presentingViewControllerAnimatedFromView:(UIView *)fromView color:(UIColor *)color completion:(void (^)(BOOL finished))completion;
- (void)backToPresentingViewControllerAtView:(UIView *)atView color:(UIColor *)color;

@end
