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
    // 读取文件
    NSDictionary *dict = [self parserFileWithPathKey:pathKey];
    // 添加子视图
    if (!view.superview || (view.superview && (view.superview != self))) {
        [self addSubview:view];
    }
    if (dict[@"percentageFrame"]) {
        // 设置比例布局约束
        [self fillView:view withPercentageWithDictionary:dict pathKey:pathKey];
    } else {
        NSLog(@"pathKey:%@ 未定义任务有效的属性,全部默认为父视图大小", pathKey);
    }
}

- (CGSize)sizeWithConstraints {
    if (self.superview) {
        CGRect frame = self.superview.bounds;
        if (CGRectIsEmpty(frame)) {
            frame.size = [self.superview sizeWithConstraints];
        }
        for (NSLayoutConstraint *constraint in self.superview.constraints) {
            NSString *constraintStr = [NSString stringWithFormat:@"%@", constraint];
            NSArray *items = [constraintStr componentsSeparatedByString:@" "];
            for (NSString *item in items) {
                if ([item rangeOfString:[NSString stringWithFormat:@"%x", (int32_t)self]].location != NSNotFound) {
                    NSInteger vlocation = [item rangeOfString:@"V:"].location;
                    if ((vlocation != NSNotFound)) {
                        NSString *subStr = item;
                        if ([subStr rangeOfString:@"-("].location == NSNotFound) {
                            while ((vlocation = [subStr rangeOfString:@"("].location) != NSNotFound) {
                                subStr = [subStr substringWithRange:NSMakeRange(vlocation + 1, subStr.length - vlocation - 1)];
                                frame.size.height = subStr.floatValue;
                                break;
                            }
                        } else {
                            while ((vlocation = [subStr rangeOfString:@"-("].location) != NSNotFound) {
                                subStr = [subStr substringWithRange:NSMakeRange(vlocation + 2, subStr.length - vlocation - 2)];
                                frame.size.height -= subStr.floatValue;
                            }
                        }
                    } else {
                        NSString *subStr = item;
                        if ([subStr rangeOfString:@"-("].location == NSNotFound) {
                            while ((vlocation = [subStr rangeOfString:@"("].location) != NSNotFound) {
                                subStr = [subStr substringWithRange:NSMakeRange(vlocation + 1, subStr.length - vlocation - 1)];
                                frame.size.width = subStr.floatValue;
                                break;
                            }
                        } else {
                            while ((vlocation = [subStr rangeOfString:@"-("].location) != NSNotFound) {
                                subStr = [subStr substringWithRange:NSMakeRange(vlocation + 2, subStr.length - vlocation - 2)];
                                frame.size.width -= subStr.floatValue;
                            }
                        }
                    }
                    break;
                }
            }
        }
        return frame.size;
    }
    return [UIScreen mainScreen].bounds.size;
}

#pragma mark - ()
- (NSDictionary *)parserFileWithPathKey:(nonnull NSString *)pathKey {
    NSArray *partPathKey = [pathKey componentsSeparatedByString:cPartPoint];
    if (partPathKey.count != 2) {
        NSAssert1(NO, @"pathKey:%@ 格式错误,正确格式:\"文件名.key\"", pathKey);
    }
    NSString *path = partPathKey[0];
    NSString *key = partPathKey[1];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data.length == 0) {
        NSAssert1(NO, @"pathKey:%@ 文件不存在或者文件内容为空", pathKey);
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *subDict = dict[key];
    if (subDict.count == 0) {
        NSAssert1(NO, @"pathKey:%@ 属性设置未找到对应的key", pathKey);
    }
    return subDict;
}

- (void)fillView:(nonnull UIView *)view withPropertiesWithDictionary:(nonnull NSDictionary *)dict {
    // 设置view的属性
    NSDictionary *attributies = dict[@"attributies"];
    if (attributies) {
        [view setValuesForKeysWithDictionary:attributies];
    }
}

- (void)fillView:(nonnull UIView *)view withPercentageWithDictionary:(nonnull NSDictionary *)dict pathKey:(nonnull NSString *)pathKey {
    // 约束
    SMPercentageFrame *percentageFrame = [[SMPercentageFrame alloc] init];
    [percentageFrame setValuesForKeysWithDictionary:dict[@"percentageFrame"]];
    SMTransPercentageFrame *trans = [SMTransPercentageFrame transWithPercentageFrame:percentageFrame pathKey:pathKey];
    // 格式检查
    for (NSString *error in trans.errors) {
        NSLog(@"%@", error);
    }
    NSAssert(!trans.errors.count, @"布局错误");
    // frame初始化，默认为父视图bounds
    CGRect bounds = self.bounds;
    CGRect frame = self.bounds;
    if (CGRectIsEmpty(frame)) {
        frame.size = [self sizeWithConstraints];
        NSLog(@"superframe:%@", NSStringFromCGRect(frame));
    }
    if (!trans.userFrame) {
        // 关闭系统约束,使用自动布局
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSDictionary *views = NSDictionaryOfVariableBindings(view);
        NSMutableDictionary *metrics = [NSMutableDictionary dictionary];
        NSString *formatHs = @"H:|[view]|";
        NSString *formatVs = @"V:|[view]|";
        NSLayoutFormatOptions optionsHs = NSLayoutFormatAlignAllTrailing;
        NSLayoutFormatOptions optionsVs = NSLayoutFormatAlignAllTrailing;
        // 横向
        if (!trans.isAutoWidth) {
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(frame)*trans.width/trans.screenScaleX] forKey:@"width"];
            if (!trans.isAutoInsetsLeft) {
                [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(frame)*trans.insetsLeft/trans.screenScaleX] forKey:@"left"];
                formatHs = @"H:|-left-[view(width)]";
            } else if (!trans.isAutoInsetsRight) {
                [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(frame)*trans.insetsRight/trans.screenScaleX] forKey:@"right"];
                formatHs = @"H:[view(width)]-right-|";
            } else {
                NSLayoutConstraint *constraintHs = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
                [self addConstraint:constraintHs];
                formatHs = @"H:[view(width)]";
                NSLog(@"H:user center");
            }
        } else {
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(frame)*trans.insetsLeft/trans.screenScaleX] forKey:@"left"];
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(frame)*trans.insetsRight/trans.screenScaleX] forKey:@"right"];
            formatHs = @"H:|-left-[view]-right-|";
        }
        // 纵向
        if (!trans.isAutoHeight) {
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetHeight(frame)*trans.height/trans.screenScaleY] forKey:@"height"];
            if (!trans.isAutoInsetsTop) {
                [metrics setObject:[NSNumber numberWithFloat:CGRectGetHeight(frame)*trans.insetsTop/trans.screenScaleY] forKey:@"top"];;
                formatVs = @"V:|-top-[view(height)]";
            } else if (!trans.isAutoInsetsBottom) {
                [metrics setObject:[NSNumber numberWithFloat:CGRectGetHeight(frame)*trans.insetsBottom/trans.screenScaleY] forKey:@"bottom"];
                formatVs = @"V:[view(height)]-bottom-|";
            } else {
                NSLayoutConstraint *constraintVs = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
                [self addConstraint:constraintVs];
                formatVs = @"V:[view(height)]";
                NSLog(@"V:user center");
            }
        } else {
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetHeight(frame)*trans.insetsTop/trans.screenScaleY] forKey:@"top"];
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetHeight(frame)*trans.insetsBottom/trans.screenScaleY] forKey:@"bottom"];
            formatVs = @"V:|-top-[view]-bottom-|";
        }
        // 增加约束
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatHs options:optionsHs metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatVs options:optionsVs metrics:metrics views:views]];
        NSLog(@"%@:%@  %@  %@", view, formatHs, formatVs, metrics);
        NSLog(@"frame:%@", NSStringFromCGSize([view sizeWithConstraints]));
    } else {
        // 横向
        if (!trans.isAutoWidth) {
            // 实际大小
            frame.size.width = CGRectGetWidth(bounds)*trans.width*trans.width/trans.screenScaleX;
            if (!trans.isAutoInsetsLeft) {
                frame.origin.x = CGRectGetWidth(bounds)*trans.insetsLeft/trans.screenScaleX;
            } else if (!trans.isAutoInsetsRight) {
                frame.origin.x = CGRectGetWidth(bounds) - CGRectGetWidth(bounds) - trans.insetsRight;
            } else {
                // 左右都为自动值 居中
                frame.origin.x = (CGRectGetWidth(bounds) - CGRectGetWidth(bounds))/2;
            }
        } else {
            frame.origin.x = CGRectGetWidth(bounds)*trans.insetsLeft/trans.screenScaleX;
            frame.size.width = CGRectGetWidth(bounds) - CGRectGetWidth(bounds)*(trans.insetsLeft + trans.insetsRight)/trans.screenScaleX;
        }
        
        // 纵向
        if (!trans.isAutoHeight) {
            // 实际大小
            frame.size.height = CGRectGetHeight(bounds)*trans.height/trans.screenScaleY;
            if (!trans.isAutoInsetsTop) {
                frame.origin.y = CGRectGetHeight(bounds)*trans.insetsTop/trans.screenScaleY;
            } else if (!trans.isAutoInsetsBottom) {
                frame.origin.y = CGRectGetHeight(bounds) - CGRectGetHeight(bounds) - CGRectGetHeight(bounds)*trans.insetsBottom/trans.screenScaleY;
            } else {
                // 左右都为自动值 居中
                frame.origin.y = (CGRectGetHeight(bounds) - CGRectGetHeight(bounds))/2;
            }
        } else {
            frame.origin.y = CGRectGetHeight(bounds)*trans.insetsTop/trans.screenScaleY;
            frame.size.height = CGRectGetHeight(bounds) - CGRectGetHeight(bounds)*(trans.insetsTop + trans.insetsBottom)/trans.screenScaleY;
        }
        // 设置子视图的frame
        view.frame = frame;
        NSLog(@"frame:%@", NSStringFromCGRect(frame));
    }
    
}

@end
