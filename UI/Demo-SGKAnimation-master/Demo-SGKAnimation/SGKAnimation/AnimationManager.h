//
//  AnimationManager.h
//  Demo-SGKAnimation
//
//  Created by buding on 15/7/2.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AnimationState) {
    AnimationStateCancel      = 0,
    AnimationStateValidate
};

@interface AnimationManager : NSObject

@property (assign, nonatomic) AnimationState animationState;

+ (instancetype)shareInstance;

- (NSString *)startAnimation;
- (void)cancelAnimation;
@end
