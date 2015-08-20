//
//  UIView+WP.h
//  WisdomPark
//
//  Created by 丁治文 on 15/3/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    WPAutoresizingFrameModeNone = 0,
    WPAutoresizingFrameModeOriginX = 1<<0,
    WPAutoresizingFrameModeOriginY = 1<<1,
    WPAutoresizingFrameModeOriginAll = WPAutoresizingFrameModeOriginX|WPAutoresizingFrameModeOriginY,
    WPAutoresizingFrameModeSizeWidth = 1<<2,
    WPAutoresizingFrameModeSizeHeight = 1<<3,
    WPAutoresizingFrameModeSizeAll = WPAutoresizingFrameModeSizeWidth|WPAutoresizingFrameModeSizeHeight,
    WPAutoresizingFrameModeAll = WPAutoresizingFrameModeOriginX|WPAutoresizingFrameModeOriginY|WPAutoresizingFrameModeSizeWidth|WPAutoresizingFrameModeSizeHeight
}WPAutoresizingFrameMode;

@interface UIView (WP)

/**
 *  设置translatesAutoresizingMaskIntoConstraints的值
 *
 *  @param views views字典或者数组
 *  @param flag  YES/NO
 */
+ (void)setTranslatesAutoresizingMaskIntoConstraintsWithViews:(id)views flag:(BOOL)flag;

/**
 *  按照屏幕比例缩放view
 *
 *  @param views    views字典或者数组
 *  @param frameMode 适配类型 WPAutoresizingFrameMode
 */
+ (void)setAutoresizingFrameWithViews:(id)views frameMode:(WPAutoresizingFrameMode)frameMode;

@end
