//
//  UIView+SM.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SMAutoresizingFrameModeNone = 0,
    SMAutoresizingFrameModeOriginX = 1<<0,
    SMAutoresizingFrameModeOriginY = 1<<1,
    SMAutoresizingFrameModeOriginAll = SMAutoresizingFrameModeOriginX|SMAutoresizingFrameModeOriginY,
    SMAutoresizingFrameModeSizeWidth = 1<<2,
    SMAutoresizingFrameModeSizeHeight = 1<<3,
    SMAutoresizingFrameModeSizeAll = SMAutoresizingFrameModeSizeWidth|SMAutoresizingFrameModeSizeHeight,
    SMAutoresizingFrameModeAll = SMAutoresizingFrameModeOriginX|SMAutoresizingFrameModeOriginY|SMAutoresizingFrameModeSizeWidth|SMAutoresizingFrameModeSizeHeight
}SMAutoresizingFrameMode;

@interface UIView (SM)

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
 *  @param frameMode 适配类型 SMAutoresizingFrameMode
 */
+ (void)setAutoresizingFrameWithViews:(id)views frameMode:(SMAutoresizingFrameMode)frameMode;

@end
