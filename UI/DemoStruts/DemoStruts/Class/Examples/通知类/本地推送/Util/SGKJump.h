//
//  SGKJump.h
//  DemoStruts
//
//  Created by 丁治文 on 15/1/12.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    kPushTypeNav,
    kPushTypeNone,
    kPushTypePresent
}kPushType;

@class SGKNotificaitonModel;
@interface SGKJump : NSObject

+ (void)jumpToAppWithNotification:(SGKNotificaitonModel *)model from:(UIViewController *)from pushType:(kPushType)type;

+ (BOOL)isCurrentAearWithNotification:(SGKNotificaitonModel *)model from:(UIViewController *)from pushType:(kPushType)type;

@end
