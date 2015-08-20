//
//  UIDevice+WP.h
//  WisdomPark
//
//  Created by 丁治文 on 15/3/11.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sys/utsname.h"

@interface UIDevice (WP)

/**
 *  设备类型标识
 *
 *  @return 设备类型标识
 */
- (NSString *)wp_deviceString;

/**
 *  设备类型名称
 *
 *  @return 设备类型名称
 */
- (NSString *)wp_deviceType;

- (BOOL)wp_isIPhone6;
- (BOOL)wp_isIPhone6Plus;
- (BOOL)wp_isIPhone5;
- (BOOL)wp_isIPhone5s;
- (BOOL)wp_isIPhone4s;

- (BOOL)wps_isIPhone4x;
- (BOOL)wps_isIPhone5x;
- (BOOL)wps_isIPhone6;
- (BOOL)wps_isIphone6Plus;

@end
