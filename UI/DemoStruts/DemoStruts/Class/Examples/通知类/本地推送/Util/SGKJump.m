//
//  SGKJump.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/12.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKJump.h"
#import "SGKNotificaitonModel.h"

@implementation SGKJump

+ (void)jumpToAppWithNotification:(SGKNotificaitonModel *)model from:(UIViewController *)from pushType:(kPushType)type{
    Class fClass = NSClassFromString(model.functionId);
    UIViewController * vc = [[fClass alloc] init];
    switch (type) {
        case kPushTypeNav:{
            UINavigationController * pFrom = (UINavigationController *)from;
            if (![SGKJump isCurrentAearWithNotification:model from:from pushType:type]) {
                [pFrom pushViewController:vc animated:YES];
            }
        }break;
            
        case kPushTypeNone:{
            if (![SGKJump isCurrentAearWithNotification:model from:from pushType:type]) {
                [from.navigationController pushViewController:vc animated:YES];
            }
        }break;
            
        case kPushTypePresent:{
            if (![SGKJump isCurrentAearWithNotification:model from:from pushType:type]) {
                [from presentViewController:vc animated:YES completion:nil];
            }
        }break;
            
        default:
            break;
    }
    
}

+ (BOOL)isCurrentAearWithNotification:(SGKNotificaitonModel *)model from:(UIViewController *)from pushType:(kPushType)type{
    Class fClass = NSClassFromString(model.functionId);
    switch (type) {
        case kPushTypeNav:{
            UINavigationController * pFrom = (UINavigationController *)from;
            if ([[pFrom.childViewControllers lastObject] isKindOfClass:fClass]) {
                return YES;
            }
        }break;
            
        case kPushTypeNone:{
            if ([from isKindOfClass:fClass]) {
                return YES;
            }
        }break;
            
        case kPushTypePresent:{
            if ([from isKindOfClass:fClass]) {
                return YES;
            }
        }break;
            
        default:
            break;
    }
    return NO;
}

@end
