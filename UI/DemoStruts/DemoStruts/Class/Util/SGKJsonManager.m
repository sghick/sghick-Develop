//
//  SGKJsonManager.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/2.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKJsonManager.h"
#import "SGKCategoryModel.h"

@implementation SGKJsonManager

+ (NSDictionary *)dictionaryWithFileName:(NSString *)fileName{
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSError * error = nil;
    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!path) {
        NSLog(@"json文件未找到");
        return nil;
    }
    if (!jsonDict) {
        NSLog(@"json文件格式错误");
        return nil;
    }
    return jsonDict;
}


@end
