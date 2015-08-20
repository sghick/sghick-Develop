//
//  UIView+WP.m
//  WisdomPark
//
//  Created by 丁治文 on 15/3/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "UIView+WP.h"

@implementation UIView (WP)

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

+ (void)setAutoresizingFrameWithViews:(id)views frameMode:(WPAutoresizingFrameMode)frameMode{
    CGPoint scaleSize = CGPointMake(WPWidthScale, WPHeightScale);
    // 数组
    if ([views isKindOfClass:[NSArray class]]) {
        for (UIView * view in views) {
            if (frameMode&WPAutoresizingFrameModeOriginX) {
                view.width *= scaleSize.x;
            }
            if (frameMode&WPAutoresizingFrameModeOriginY) {
                view.height *= scaleSize.y;
            }
            if (frameMode&WPAutoresizingFrameModeSizeHeight) {
                view.left *= scaleSize.x;
            }
            if (frameMode&WPAutoresizingFrameModeSizeWidth) {
                view.top *= scaleSize.y;
            }
        }
    }
    // 字典
    else if ([views isKindOfClass:[NSDictionary class]]){
        NSArray * keys = ((NSDictionary *)views).allKeys;
        for (NSString * key in keys) {
            UIView * view = [views objectForKey:key];
            if (frameMode&WPAutoresizingFrameModeOriginX) {
                view.width *= scaleSize.x;
            }
            if (frameMode&WPAutoresizingFrameModeOriginY) {
                view.height *= scaleSize.y;
            }
            if (frameMode&WPAutoresizingFrameModeSizeHeight) {
                view.left *= scaleSize.x;
            }
            if (frameMode&WPAutoresizingFrameModeSizeWidth) {
                view.top *= scaleSize.y;
            }
        }
    }
}
@end
