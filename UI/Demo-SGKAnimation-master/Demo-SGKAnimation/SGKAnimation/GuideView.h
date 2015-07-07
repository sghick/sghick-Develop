//
//  GuideView.h
//  Demo-SGKAnimation
//
//  Created by buding on 15/7/2.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GuideViewAnimationState) {
    GuideViewAnimationStateCancel      = 0,
    GuideViewAnimationStateValidate
};

@interface GuideView : UIView

@property (assign, readonly, nonatomic) GuideViewAnimationState animationState;

- (void)playAnimationFromLeft:(BOOL)fromLeft;
- (void)playAnimationFromLeft:(BOOL)fromLeft completion:(void (^)(BOOL finished))completion;
- (void)cancelAnimation;
- (void)removeAllViews;

@end
