//
//  SMLogSys.m
//  Demo-SMLog
//
//  Created by buding on 15/7/31.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMLogSys.h"
#import "SMLogConfig.h"

@implementation SMLogSys

+ (void)log:(NSString *)log fcName:(NSString *)fcName {
    [self log:log fcName:(NSString *)fcName type:SMLogTypeDefault];
}

+ (void)log:(NSString *)log fcName:(NSString *)fcName type:(SMLogType)type {
    
#if __DUBUG__
    
#if __OUT_CMD__
    if (type & SMLogTypeCmd) {
        [self outputCmdLog:log fcName:(NSString *)fcName];
    }
#endif
    
#if __OUT_FILE__
    if (type & SMLogTypeFile) {
        NSString *fileDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        [self outputFileLog:log fcName:(NSString *)fcName fileDoc:fileDoc];
    }
#endif
    
#if __OUT_FILE_PATH__
    if (type & SMLogTypeFilePath) {
        NSString *fileDoc = __PATH_FOR_OUT_FILE__;
        [self outputFileLog:log fcName:(NSString *)fcName fileDoc:fileDoc];
    }
#endif
    
#endif
}

+ (void)outputCmdLog:(NSString *)log fcName:(NSString *)fcName {
    NSString *content = SMToString(@"%@%@:%@", SMLogHeader, fcName, log);
    NSLog(@"%@", content);
}

+ (void)outputFileLog:(NSString *)log fcName:(NSString *)fcName fileDoc:(NSString *)fileDoc{
    NSDate *date = [NSDate date];
    NSString *logDate = SMDateToString(date, @"yyyy-MM-dd hh:mm:ss.SSSS");
    NSString *content = SMToString(@"%@ %@%@:%@", logDate, SMLogHeader, fcName, log);
    NSString *fileName = [SMDateToString(date, @"yyyyMMdd") stringByAppendingPathExtension:@"log"];
    NSString *filePath = [fileDoc stringByAppendingPathComponent:fileName];
    NSString *oldLog = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *newLog = content;
    if (oldLog) {
        newLog = [oldLog stringByAppendingFormat:@"\n%@", content];
    }
    [newLog writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
