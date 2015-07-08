//
//  PushView.m
//  Demo-AnimatePushViewController
//
//  Created by dingzhiwen on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "PushView.h"
#define kAnimationDuration 0.3f

@interface PushView ()

@end

@implementation PushView

#pragma mark - use for sub class
- (void)presentingViewControllerAnimatedFromView:(UIView *)fromView color:(UIColor *)color completion:(void (^)(BOOL finished))completion {
    NSLog(@"present  === animated");
    UIView *animatedView = [[UIView alloc] initWithFrame:fromView.frame];
    animatedView.backgroundColor = (color?color:fromView.backgroundColor);
    animatedView.layer.cornerRadius = 5.0;
    animatedView.alpha = 0.5f;
    [self addSubview:animatedView];
    [UIView animateWithDuration:(self.animationDuration?self.animationDuration:kAnimationDuration) animations:^{
        animatedView.frame = self.bounds;
        animatedView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [animatedView removeFromSuperview];
        }
        else {
            [self performSelectorInBackground:@selector(removeViewFromSuperviewInBackgroundOfView:) withObject:animatedView];
        }
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)backToPresentingViewControllerAtView:(UIView *)atView color:(UIColor *)color {
    NSLog(@"back  === animated");
    UIView *animatedView = [[UIView alloc] initWithFrame:self.bounds];
    animatedView.backgroundColor = (color?color:atView.backgroundColor);
    animatedView.layer.cornerRadius = 5.0;
    animatedView.alpha = 1.0f;
    [self addSubview:animatedView];
    [UIView animateWithDuration:(self.animationDuration?self.animationDuration:kAnimationDuration) animations:^{
        animatedView.frame = atView.frame;
        animatedView.alpha = 0.5f;
    } completion:^(BOOL finished) {
        if (finished) {
            [animatedView removeFromSuperview];
        }
        else {
            [self performSelectorInBackground:@selector(removeViewFromSuperviewInBackgroundOfView:) withObject:animatedView];
        }
    }];
    
}

- (void)removeViewFromSuperviewInBackgroundOfView:(UIView *)view {
    [NSThread sleepForTimeInterval:kAnimationDuration];
    [view removeFromSuperview];
}

@end
