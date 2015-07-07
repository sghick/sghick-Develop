//
//  SGConfigManager.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGConfigManager.h"
@implementation SGConfig

@end

#define kUserDefaultsCenterOfConfigManager @"__kUserDefaultsCenterOfConfigManager"

@implementation SGConfigManager

+ (instancetype)defaultConfigManager{
    static SGConfigManager * configManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configManager = [[SGConfigManager alloc] init];
        [configManager readFile];
    });
    return configManager;
}

#pragma mark - ()
- (SGConfig *)curConfig{
    return self.configs[self.curItemName];
}

- (void)save{
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
    NSDictionary * dict = self.dictionary;
    [dict writeToFile:plistPath atomically:YES];
}

- (BOOL)readFile{
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableDictionary * configs = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (dict) {
        self.curItemName = dict[@"curItemName"];
        NSDictionary * dictConfigs = dict[@"configs"];
        for (NSString * key in dictConfigs.allKeys) {
            SGConfig * config = [[SGConfig alloc] init];
            [config setValuesWithDictionary:dictConfigs[key] classNamesMapper:@{parserReturnTypeMainModelOfKey: @"SGConfig"}];
            [configs setValue:config forKey:key];
        }
        self.configs = configs;
        return YES;
    }
    return NO;
}

@end
