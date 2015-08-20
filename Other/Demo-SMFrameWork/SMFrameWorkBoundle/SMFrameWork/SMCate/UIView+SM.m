//
//  UIView+SM.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "UIView+SM.h"

@implementation UIView (SM)

+ (void)setTranslatesAutoresizingMaskIntoConstraintsWithViews:(id)views flag:(BOOL)flag{
    // 数组
    if ([views isKindOfClass:[NSArray class]]) {
        for (UIView * view in views) {
            [view setTranslatesAutoresizingMaskIntoConstraints:flag];
        }
    }
    // 字典
    else if ([views isKindOfClass:[NSDictionary class]]){
        NSArray * keys = ((NSDictionary *)views).allKeys;
        for (NSString * key in keys) {
            [((UIView *)[views objectForKey:key]) setTranslatesAutoresizingMaskIntoConstraints:flag];
        }
    }
}

+ (void)setAutoresizingFrameWithViews:(id)views frameMode:(SMAutoresizingFrameMode)frameMode{
    CGPoint scalePoint = CGPointMake(SMWidthScale, SMHeightScale);
    // 数组
    if ([views isKindOfClass:[NSArray class]]) {
        for (UIView * view in views) {
            if (frameMode&SMAutoresizingFrameModeOriginX) {
                view.width *= scalePoint.x;
            }
            if (frameMode&SMAutoresizingFrameModeOriginY) {
                view.height *= scalePoint.y;
            }
            if (frameMode&SMAutoresizingFrameModeSizeHeight) {
                view.left *= scalePoint.x;
            }
            if (frameMode&SMAutoresizingFrameModeSizeWidth) {
                view.top *= scalePoint.y;
            }
        }
    }
    // 字典
    else if ([views isKindOfClass:[NSDictionary class]]){
        NSArray * keys = ((NSDictionary *)views).allKeys;
        for (NSString * key in keys) {
            UIView * view = [views objectForKey:key];
            if (frameMode&SMAutoresizingFrameModeOriginX) {
                view.width *= scalePoint.x;
            }
            if (frameMode&SMAutoresizingFrameModeOriginY) {
                view.height *= scalePoint.y;
            }
            if (frameMode&SMAutoresizingFrameModeSizeHeight) {
                view.left *= scalePoint.x;
            }
            if (frameMode&SMAutoresizingFrameModeSizeWidth) {
                view.top *= scalePoint.y;
            }
        }
    }
}

@end
