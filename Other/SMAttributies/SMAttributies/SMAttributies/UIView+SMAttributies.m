//
//  UIView+SMAttributies.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

// 分隔符
#define cPartPoint      @"."

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
    if (!view.superview || (view.superview && (view.superview != self))) {
        [self addSubview:view];
    }
    
    // 设置view的属性
    NSDictionary *attributies = subDict[@"attributies"];
    if (attributies) {
        [self setValuesForKeysWithDictionary:attributies];
    }
    
    if (subDict[@"percentageFrame"]) {
        // 约束
        SMPercentageFrame *percentageFrame = [[SMPercentageFrame alloc] init];
        [percentageFrame setValuesForKeysWithDictionary:subDict[@"percentageFrame"]];
        SMTransPercentageFrame *trans = [SMTransPercentageFrame transWithPercentageFrame:percentageFrame pathKey:pathKey];
        // 格式检查
        for (NSString *error in trans.errors) {
            NSLog(@"%@", error);
        }
        NSAssert(!trans.errors.count, @"布局错误");
        
    } else if (subDict[@"realFrame"]) {
        // 设置view的实际frame,设置了约束,frame自动失效
        SMRealFrame *realFrame = [[SMRealFrame alloc] init];
        [realFrame setValuesForKeysWithDictionary:subDict[@"realFrame"]];
        SMTransRealFrame *trans = [SMTransRealFrame transWithRealFrame:realFrame pathKey:pathKey];
        // 格式检查
        for (NSString *error in trans.errors) {
            NSLog(@"%@", error);
        }
        NSAssert(!trans.errors.count, @"布局错误");
        
        // frame初始化，默认为父视图bounds
        CGRect frame = self.bounds;
        // 横向
        if (!trans.isAutoWidth) {
            // 实际大小
            frame.size.width = trans.width*trans.scaleX;
            if (!trans.isAutoInsetsLeft) {
                frame.origin.x = trans.insetsLeft;
            } else if (!trans.isAutoInsetsRight) {
                frame.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(frame) - trans.insetsRight;
            } else {
                // 左右都为自动值 居中
                frame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(frame))/2;
            }
        } else {
            frame.origin.x = trans.insetsLeft;
            frame.size.width = CGRectGetWidth(self.bounds) - trans.insetsLeft - trans.insetsRight;
        }
        
        // 纵向
        if (!trans.isAutoHeight) {
            // 实际大小
            frame.size.height = trans.height*trans.scaleY;
            if (!trans.isAutoInsetsTop) {
                frame.origin.y = trans.insetsTop;
            } else if (!trans.isAutoInsetsBottom) {
                frame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(frame) - trans.insetsBottom;
            } else {
                // 左右都为自动值 居中
                frame.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(frame))/2;
            }
        } else {
            frame.origin.y = trans.insetsTop;
            frame.size.height = CGRectGetHeight(self.bounds) - trans.insetsTop - trans.insetsBottom;
        }
        // 设置子视图的frame
        view.frame = frame;
    } else {
        NSAssert1(NO, @"pathKey:%@ 未定义任务有效的属性", pathKey);
    }
}

@end
