//
//  UIView+AnimationView.h
//  Demo-SGKAnimation
//
//  Created by buding on 15/7/2.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AnimationView)

+ (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;

/**
 *  初始化一个动画
 *
 *  @return 返回动画的唯一标识（用于取消动画）
 */
- (NSString *)sgk_animateMakeNew;

- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval newOrigin:(CGRect)newOrigin completion:(void (^)(BOOL))completion;
- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval newSize:(CGRect)newSize completion:(void (^)(BOOL))completion;
- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval newFrame:(CGRect)newFrame completion:(void (^)(BOOL))completion;

- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval scale:(CGFloat)scale completion:(void (^)(BOOL))completion;
- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval translationX:(CGFloat)translationX completion:(void (^)(BOOL))completion;
- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval translationY:(CGFloat)translationY completion:(void (^)(BOOL))completion;
- (void)sgk_animateFromTimeInterval:(NSTimeInterval)timeInterval toTimeInterval:(NSTimeInterval)toTimeInterval transform:(CGAffineTransform)transform completion:(void (^)(BOOL))completion;

/**
 *  取消一个动画
 *
 *  @param animateId 动画的唯一标识
 */
- (void)sgk_animateCancel:(NSString *)animateId;

@end
