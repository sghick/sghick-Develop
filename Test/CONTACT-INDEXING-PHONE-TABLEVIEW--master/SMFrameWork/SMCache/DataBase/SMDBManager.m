//
//  SMDBManager.m
//  Hahaha
//
//  Created by buding on 15/9/17.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "SMDBManager.h"
#import "SMDBHelper.h"

@interface SMDBManager ()

@property (strong, nonatomic) NSMutableDictionary *dbHelpers;

@end

@implementation SMDBManager

static dispatch_once_t once_token;
static SMDBManager *_manager = nil;

+ (SMDBHelper *)dbHelperWithDBPath:(NSString *)DBPath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *doc = [DBPath stringByDeletingLastPathComponent];
    if (![fileManager fileExistsAtPath:doc]) {
        [fileManager createDirectoryAtPath:doc withIntermediateDirectories:YES attributes:nil error:nil];
    }
    SMDBManager *manager = [SMDBManager shareInstance];
    SMDBHelper *dbHelper = manager.dbHelpers[DBPath];
    if (!dbHelper) {
        dbHelper = [[SMDBHelper alloc] initWithDBPath:DBPath];
        [manager.dbHelpers setObject:dbHelper forKey:DBPath];
    }
    return dbHelper;
}

+ (instancetype)shareInstance {
    dispatch_once(&once_token, ^{
        _manager = [[SMDBManager alloc] init];
        _manager.dbHelpers = [NSMutableDictionary dictionary];
    });
    return _manager;
}



@end
