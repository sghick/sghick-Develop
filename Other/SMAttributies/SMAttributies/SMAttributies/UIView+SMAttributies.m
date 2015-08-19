//
//  UIView+SMAttributies.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#define cScreenWidth    [UIScreen mainScreen].bounds.size.width
#define cScreenHeight   [UIScreen mainScreen].bounds.size.height

// 分隔符
#define cPartComma      @","
#define cPartPoint      @"."
// 自动符
#define cAuto           @"-"
// 使用比例宽,使用scale中的值
#define cScaleX          @"x"
// 使用比例高,使用scale中的值
#define cScaleY          @"y"

#import "UIView+SMAttributies.h"
#import "SMAttributiesModel.h"

@implementation UIView (SMAttributies)

- (void)addSubview:(nonnull UIView *)view attributePathKey:(nonnull NSString *)pathKey {
    NSArray *partPathKey = [pathKey componentsSeparatedByString:cPartPoint];
    if (partPathKey.count != 2) {
        NSAssert1(NO, @"pathKey:%@ 格式错误,正确格式:\"文件名.key\"", pathKey);
        return;
    }
    NSString *path = partPathKey[0];
    NSString *key = partPathKey[1];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data.length == 0) {
        NSAssert1(NO, @"pathKey:%@ 文件不存在或者文件内容为空", pathKey);
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *subDict = dict[key];
    if (subDict.count == 0) {
        NSAssert1(NO, @"pathKey:%@ 属性设置未找到对应的key", pathKey);
        return;
    }
    // 添加子视图
    [self addSubview:view];
    
    // 设置view的属性
    NSDictionary *attributies = subDict[@"attributies"];
    if (attributies) {
        [self setValuesForKeysWithDictionary:attributies];
    }
    
    if (subDict[@"percentageFrame"]) {
        // 约束
        SMPercentageFrame *percentageFrame = [[SMPercentageFrame alloc] init];
        [percentageFrame setValuesForKeysWithDictionary:subDict[@"percentageFrame"]];
    } else if (subDict[@"realFrame"]) {
        // 设置view的实际frame,设置了约束,frame自动失效
        SMRealFrame *realFrame = [[SMRealFrame alloc] init];
        [realFrame setValuesForKeysWithDictionary:subDict[@"realFrame"]];
        NSArray *partScale = [realFrame.scale componentsSeparatedByString:cPartComma];
        if (partScale && partScale.count != 2) {
            NSAssert1(NO, @"pathKey:%@ realFrame.scale格式错误,正确格式:\"-,-\"", pathKey);
        } else if (partScale) {
            
        }
        NSArray *partMagin = [realFrame.insets componentsSeparatedByString:cPartComma];
        if (partMagin && partMagin.count != 4) {
            NSAssert1(NO, @"pathKey:%@ realFrame.insets格式错误,正确格式:\"-,-,-,-\"", pathKey);
        } else if (partMagin) {
            
        }
        // frame初始化，默认为父视图bounds
        CGRect frame = self.bounds;
        
        // 宽
        if ([realFrame.width isEqualToString:cAuto]) {
            // 自动
            
        } else if ([realFrame.width rangeOfString:cScaleX].location != NSNotFound) {
            // 用比例x
            
        } else if ([realFrame.width rangeOfString:cScaleY].location != NSNotFound) {
            // 用比例y
        }
        
        // 高
        if ([realFrame.height isEqualToString:cAuto]) {
            // 自动
            
        } else if ([realFrame.height rangeOfString:cScaleX].location != NSNotFound) {
            // 用比例x
            
        } else if ([realFrame.height rangeOfString:cScaleY].location != NSNotFound) {
            // 用比例y
        }
        
        // 设置子视图的frame
        view.frame = frame;
    } else {
        NSAssert1(NO, @"pathKey:%@ 未定义任务有效的属性", pathKey);
    }
}

@end
