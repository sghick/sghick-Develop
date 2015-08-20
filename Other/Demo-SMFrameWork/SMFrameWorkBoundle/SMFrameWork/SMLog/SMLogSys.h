//
//  SMLogSys.h
//  Demo-SMLog
//
//  Created by buding on 15/7/31.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SMLogType) {
    SMLogTypeDefault        = 0xFFFFFF,
    SMLogTypeCmd            = 1 << 1,
    SMLogTypeFile           = 2 << 1,
    SMLogTypeFilePath       = 3 << 1
};

@interface SMLogSys : NSObject

+ (void)log:(NSString *)log fcName:(NSString *)fcName;
+ (void)log:(NSString *)log fcName:(NSString *)fcName type:(SMLogType)type;

@end
