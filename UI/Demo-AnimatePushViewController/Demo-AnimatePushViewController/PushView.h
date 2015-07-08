//
//  PushView.h
//  Demo-AnimatePushViewController
//
//  Created by buding on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

// realize at sub class and used at presentedViewController
@protocol PushView <NSObject>

@optional
- (void)backToPresentingViewControllerWithTag:(int)tag;

@end

@interface PushView : UIView

// use for sub class
- (void)presentingViewControllerAnimatedFromView:(UIView *)fromView completion:(void (^)(BOOL finished))completion;
- (void)backToPresentingViewControllerAtView:(UIView *)atView ;

@end
