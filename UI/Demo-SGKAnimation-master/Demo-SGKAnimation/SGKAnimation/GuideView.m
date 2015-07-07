//
//  GuideView.m
//  Demo-SGKAnimation
//
//  Created by buding on 15/7/2.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "GuideView.h"

@implementation GuideView

- (void)playAnimationFromLeft:(BOOL)fromLeft {
    [self playAnimationFromLeft:fromLeft completion:nil];
    // for sub class
}

- (void)playAnimationFromLeft:(BOOL)fromLeft completion:(void (^)(BOOL))completion {
    _animationState = GuideViewAnimationStateValidate;
    // for sub class
}

- (void)cancelAnimation {
    _animationState = GuideViewAnimationStateCancel;
    // for sub class
}

- (void)removeAllViews {
    // for sub class
}

@end
