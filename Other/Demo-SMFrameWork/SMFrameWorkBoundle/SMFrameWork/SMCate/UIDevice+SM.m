//
//  UIDevice+SM.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "UIDevice+SM.h"
#import "sys/utsname.h"

@implementation UIDevice (SM)

- (NSString *)sm_deviceString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

- (NSString *)sm_deviceType{
    NSString * deviceString = [self sm_deviceString];
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    return @"暂未识别此设备";
}

- (BOOL)sm_isIPhone6{
    if ([@"iPhone7,2" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    return NO;
}

- (BOOL)sm_isIPhone6Plus{
    if ([@"iPhone7,1" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    return NO;
}

- (BOOL)sm_isIPhone5{
    if ([@"iPhone5,1" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    if ([@"iPhone5,2" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    return NO;
}

- (BOOL)sm_isIPhone5s{
    if ([@"iPhone6,1" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    if ([@"iPhone6,2" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    return NO;
}

- (BOOL)sm_isIPhone4s{
    if ([@"iPhone4,1" isEqualToString:[self sm_deviceString]] ) {
        return YES;
    }
    return NO;
}

- (BOOL)sms_isIPhone4x {
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        return YES;
    }
    return NO;
}

- (BOOL)sms_isIPhone5x {
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        return YES;
    }
    return NO;
}

- (BOOL)sms_isIPhone6 {
    if ([[UIScreen mainScreen] bounds].size.height == 667) {
        return YES;
    }
    return NO;
}

- (BOOL)sms_isIphone6Plus {
    if ([[UIScreen mainScreen] bounds].size.height == 736) {
        return YES;
    }
    return NO;
}

@end
