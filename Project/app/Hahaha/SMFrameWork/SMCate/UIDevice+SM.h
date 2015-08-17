//
//  UIDevice+SM.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (SM)

/**
 *  设备类型标识
 *
 *  @return 设备类型标识
 */
- (NSString *)sm_deviceString;

/**
 *  设备类型名称
 *
 *  @return 设备类型名称
 */
- (NSString *)sm_deviceType;

- (BOOL)sm_isIPhone6;
- (BOOL)sm_isIPhone6Plus;
- (BOOL)sm_isIPhone5;
- (BOOL)sm_isIPhone5s;
- (BOOL)sm_isIPhone4s;

- (BOOL)sms_isIPhone4x;
- (BOOL)sms_isIPhone5x;
- (BOOL)sms_isIPhone6;
- (BOOL)sms_isIphone6Plus;

@end
