//
//  PushView.m
//  Demo-AnimatePushViewController
//
//  Created by buding on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "PushView.h"
#define kAnimationDuration 0.3f

@interface PushView ()

@end

@implementation PushView

#pragma mark - use for sub class
- (void)presentingViewControllerAnimatedFromView:(UIView *)fromView completion:(void (^)(BOOL finished))completion {
    NSLog(@"present  === animated");
    UIView *animatedView = [[UIView alloc] initWithFrame:fromView.frame];
    animatedView.backgroundColor = fromView.backgroundColor;
    animatedView.layer.cornerRadius = 5.0;
    [self addSubview:animatedView];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        animatedView.frame = self.bounds;
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

- (void)backToPresentingViewControllerAtView:(UIView *)atView {
    NSLog(@"back  === animated");
    UIView *animatedView = [[UIView alloc] initWithFrame:self.bounds];
    animatedView.backgroundColor = atView.backgroundColor;
    animatedView.layer.cornerRadius = 5.0;
    [self addSubview:animatedView];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        animatedView.frame = atView.frame;
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
