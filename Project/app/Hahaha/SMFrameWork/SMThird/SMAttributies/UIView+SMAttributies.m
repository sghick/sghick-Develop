//
//  UIView+SMAttributies.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#define NSLog(...)

// 系统版本
#define SMSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
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
        // 布局文件
        SMPercentageFrame *percentageFrame = [[SMPercentageFrame alloc] init];
        [percentageFrame setValuesForKeysWithDictionary:dict[@"percentageFrame"]];
        // 设置比例布局约束
        [self fillView:view percentageFrame:percentageFrame pathKey:pathKey];
    } else {
        NSLog(@"pathKey:%@ 未定义任务有效的属性,全部默认为父视图大小", pathKey);
    }
}

- (void)showNetLineWithRowAndColoum:(CGPoint)rowAndColoum lineColor:(UIColor *)lineColor netType:(SMNetLineType)netType alpha:(CGFloat)alpha {
    // 线条颜色
    UIColor *color = (lineColor?lineColor:[UIColor blackColor]);
    // 线条精细
    CGFloat lineWitdh = 1;
    CGRect frame = [self frameWithNetType:netType];
    // 每列的宽
    CGFloat perWidth = CGRectGetWidth(frame)/rowAndColoum.x;
    // 每行的高
    CGFloat perHeight = CGRectGetHeight(frame)/rowAndColoum.y;
    // 画列
    for (int i = 0; i < rowAndColoum.x; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i*perWidth, frame.origin.y, lineWitdh, CGRectGetHeight(frame))];
        line.backgroundColor = color;
        [self addSubview:line];
    }
    // 画行
    for (int i = 0; i < rowAndColoum.y; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.origin.y + i*perHeight, CGRectGetWidth(frame), lineWitdh)];
        line.backgroundColor = color;
        [self addSubview:line];
    }
    if (netType&SMNetLineTypeShowNumber) {
        for (int i = 0; i < rowAndColoum.y; i++) {
            for (int j = 0; j < rowAndColoum.x; j++) {
                UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(j*perWidth + 1, frame.origin.y + i*perHeight + 1, perWidth - 1, perHeight - 1)];
                num.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:0/255.0 alpha:alpha];
                num.text = [NSString stringWithFormat:@"%d,%d", j, i];
                num.textAlignment = NSTextAlignmentCenter;
                [self addSubview:num];
            }
        }
    }
}

- (CGRect)frameWithNetType:(SMNetLineType)netType {
    CGRect frame = self.bounds;
    // 用于计算的高
    if (SMSystemVersion > 6) {
        if (netType&SMNetLineTypeAuto) {
            CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            frame.origin.y += statusBarHeight;
            frame.size.height -= statusBarHeight;
            
            CGFloat navBarHeight = [UINavigationBar appearance].frame.size.height;
            frame.origin.y += navBarHeight;
            frame.size.height -= navBarHeight;
            
            CGFloat tabBarHeight = [UITabBar appearance].frame.size.height;
            frame.size.height -= tabBarHeight;
            
        } else {
            if (netType&SMNetLineTypeUseStatusBar) {
                CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
                frame.origin.y += statusBarHeight;
                frame.size.height -= statusBarHeight;
            }
            if (netType&SMNetLineTypeUseNavBar) {
                frame.origin.y += 44;
                frame.size.height -= 44;
            }
            if (netType&SMNetLineTypeUseTabBar) {
                frame.size.height -= 49;
            }
        }
    }
    return frame;
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

#pragma mark - parser
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

- (void)fillView:(nonnull UIView *)view percentageFrame:(nonnull SMPercentageFrame *)percentageFrame pathKey:(nonnull NSString *)pathKey {
    // 约束
    SMTransPercentageFrame *trans = [SMTransPercentageFrame transWithPercentageFrame:percentageFrame pathKey:pathKey];
    // 格式检查
    for (NSString *error in trans.errors) {
        NSLog(@"%@", error);
    }
    NSAssert(!trans.errors.count, @"布局错误");
    if (!trans.useFrame) {
        if (trans.useNetFrame) {
            [self addNetConstraints2WithTrans:trans forView:view];
        } else {
            [self addConstraints2WithTrans:trans forView:view];
        }
    } else {
        if (trans.useNetFrame) {
            [self addNetFramesWithTrans:trans forView:view];
        } else {
            [self addFramesWithTrans:trans forView:view];
        }
    }
    
}

// 添加约束
- (void)addConstraintsWithTrans:(SMTransPercentageFrame *)trans forView:(UIView *)view {
    // frame初始化，默认为父视图bounds
    CGRect bounds = [self frameWithNetType:trans.netType];
    if (CGRectIsEmpty(bounds)) {
        bounds.size = [self sizeWithConstraints];
        NSLog(@"superBounds:%@", NSStringFromCGRect(bounds));
    }
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
        if (trans.isAutoInsetsLeft && trans.isAutoInsetsRight) {
            NSAssert1(NO, @"%@:不能同时定义insetLeft或者insetRight", view);
        }
        if (!trans.isAutoInsetsLeft && !trans.isAutoInsetsRight) {
            NSAssert1(NO, @"%@:未定义insetLeft或者insetRight", view);
        }
        [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(bounds)*trans.width/trans.screenScaleX] forKey:@"width"];
        if (!trans.isAutoInsetsLeft) {
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(bounds)*trans.insetsLeft/trans.screenScaleX] forKey:@"left"];
            formatHs = @"H:|-left-[view(width)]";
        } else if (!trans.isAutoInsetsRight) {
            [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(bounds)*trans.insetsRight/trans.screenScaleX] forKey:@"right"];
            formatHs = @"H:[view(width)]-right-|";
        } else {
            NSLayoutConstraint *constraintHs = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
            [self addConstraint:constraintHs];
            formatHs = @"H:[view(width)]";
            NSLog(@"H:user center");
        }
    } else {
        if (trans.isAutoInsetsLeft || trans.isAutoInsetsRight) {
            NSAssert1(NO, @"%@:必须同时定义insetLeft或者insetRight", view);
        }
        [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(bounds)*trans.insetsLeft/trans.screenScaleX] forKey:@"left"];
        [metrics setObject:[NSNumber numberWithFloat:CGRectGetWidth(bounds)*trans.insetsRight/trans.screenScaleX] forKey:@"right"];
        formatHs = @"H:|-left-[view]-right-|";
    }
    // 纵向
    if (!trans.isAutoHeight) {
        [metrics setObject:[NSNumber numberWithFloat:CGRectGetHeight(bounds)*trans.height/trans.screenScaleY] forKey:@"height"];
        if (!trans.isAutoInsetsTop) {
            [metrics setObject:[NSNumber numberWithFloat:(bounds.origin.y + CGRectGetHeight(bounds)*trans.insetsTop/trans.screenScaleY)] forKey:@"top"];
            formatVs = @"V:|-top-[view(height)]";
        } else if (!trans.isAutoInsetsBottom) {
            CGFloat bottom = CGRectGetHeight(self.bounds) - (bounds.origin.y + CGRectGetHeight(bounds));
            [metrics setObject:[NSNumber numberWithFloat:(bottom + CGRectGetHeight(bounds)*trans.insetsBottom/trans.screenScaleY)] forKey:@"bottom"];
            formatVs = @"V:[view(height)]-bottom-|";
        } else {
            NSLayoutConstraint *constraintVs = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
            [self addConstraint:constraintVs];
            formatVs = @"V:[view(height)]";
            NSLog(@"V:user center");
        }
    } else {
        CGFloat bottom = CGRectGetHeight(self.bounds) - (bounds.origin.y + CGRectGetHeight(bounds));
        [metrics setObject:[NSNumber numberWithFloat:(bounds.origin.y + CGRectGetHeight(bounds)*trans.insetsTop/trans.screenScaleY)] forKey:@"top"];
        [metrics setObject:[NSNumber numberWithFloat:(bottom + CGRectGetHeight(bounds)*trans.insetsBottom/trans.screenScaleY)] forKey:@"bottom"];
        formatVs = @"V:|-top-[view]-bottom-|";
    }
    // 增加约束
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatHs options:optionsHs metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatVs options:optionsVs metrics:metrics views:views]];
    NSLog(@"%@:%@  %@  %@", view, formatHs, formatVs, metrics);
    NSLog(@"frame:%@", [view constraints]);
}

- (void)addConstraints2WithTrans:(SMTransPercentageFrame *)trans forView:(UIView *)view {
    // frame初始化，默认为父视图bounds
    CGRect bounds = [self frameWithNetType:trans.netType];
    if (CGRectIsEmpty(bounds)) {
        bounds.size = [self sizeWithConstraints];
        NSLog(@"superBounds:%@", NSStringFromCGRect(bounds));
    }
    // 关闭系统约束,使用自动布局
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 大小
    if (!trans.isAutoWidth) {
        if (trans.isAutoInsetsLeft && trans.isAutoInsetsRight) {
            NSAssert1(NO, @"%@:未定义insetLeft或者insetRight", view);
        }
        if (!trans.isAutoInsetsLeft && !trans.isAutoInsetsRight) {
            NSAssert1(NO, @"%@:不能同时定义insetLeft和insetRight", view);
        }
        // 横向
        [view addConstraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:(CGRectGetWidth(bounds)*trans.width/trans.screenScaleX)];
        if (!trans.isAutoInsetsLeft) {
            [view addConstraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:((trans.insetsLeft + trans.width/2)/(trans.screenScaleX/2)) constant:0];
        }
        if (!trans.isAutoInsetsRight) {
            [view addConstraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:(((trans.screenScaleX - trans.insetsRight - trans.width) + trans.width/2)/(trans.screenScaleX/2)) constant:0];
        }
    } else {
        if (trans.isAutoInsetsLeft || trans.isAutoInsetsRight) {
//            NSAssert1(NO, @"%@:必须同时定义insetLeft或者insetRight", view);
        }
        CGFloat transWidth = trans.screenScaleX - trans.insetsLeft - trans.insetsRight;
        // 横向
        [view addConstraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:(CGRectGetWidth(bounds)*transWidth/trans.screenScaleX)];
        if (!trans.isAutoInsetsLeft) {
            [view addConstraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:((trans.insetsLeft + transWidth/2)/(trans.screenScaleX/2)) constant:0];
        }
    }
    
    if (!trans.isAutoHeight) {
        if (trans.isAutoInsetsTop && trans.isAutoInsetsBottom) {
            NSAssert1(NO, @"%@:不能同时定义insetTop或者insetBottom", view);
        }
        if (!trans.isAutoInsetsTop && !trans.isAutoInsetsBottom) {
            NSAssert1(NO, @"%@:未定义insetTop或者insetBottom", view);
        }
        // 纵向
        [view addConstraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:(CGRectGetHeight(bounds)*trans.height/trans.screenScaleY)];
        CGFloat top = bounds.origin.y;
        CGFloat bottom = CGRectGetHeight(self.bounds) - (bounds.origin.y + CGRectGetHeight(bounds));
        CGFloat transEt = top*trans.screenScaleY/CGRectGetHeight(bounds);
        CGFloat transEb = bottom*trans.screenScaleY/CGRectGetHeight(bounds);
        CGFloat transTop = transEt + trans.insetsTop;
        CGFloat transBottom = transEb + trans.insetsBottom;
        CGFloat transscreenScaleY = trans.screenScaleY + transEt + transEb;
        if (!trans.isAutoInsetsTop) {
            [view addConstraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:((transTop + trans.height/2)/(transscreenScaleY/2)) constant:0];
        }
        if (!trans.isAutoInsetsBottom) {
            [view addConstraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:(((transscreenScaleY - transBottom - trans.height) + trans.height/2)/(transscreenScaleY/2)) constant:0];
        }
    } else {
        if (trans.isAutoInsetsTop || trans.isAutoInsetsBottom) {
//            NSAssert1(NO, @"%@:必须同时定义insetTop或者insetBottom", view);
        }
        CGFloat top = bounds.origin.y;
        CGFloat bottom = CGRectGetHeight(self.bounds) - (bounds.origin.y + CGRectGetHeight(bounds));
        CGFloat transEt = top*trans.screenScaleY/CGRectGetHeight(bounds);
        CGFloat transEb = bottom*trans.screenScaleY/CGRectGetHeight(bounds);
        CGFloat transTop = transEt + trans.insetsTop;
        CGFloat transscreenScaleY = trans.screenScaleY + transEt + transEb;
        // 纵向
        [view addConstraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:(CGRectGetHeight(bounds)*(trans.screenScaleY - trans.insetsTop - trans.insetsBottom)/trans.screenScaleY)];
        if (!trans.isAutoInsetsTop) {
            [view addConstraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:((transTop + (trans.screenScaleY - trans.insetsTop - trans.insetsBottom)/2)/(transscreenScaleY/2)) constant:0];
        }
    }
    NSLog(@"frame:%@", [view constraints]);
}

- (void)addNetConstraintsWithTrans:(SMTransPercentageFrame *)trans forView:(UIView *)view {
    // frame初始化，默认为父视图bounds
    CGRect bounds = [self frameWithNetType:trans.netType];
    if (CGRectIsEmpty(bounds)) {
        bounds.size = [self sizeWithConstraints];
        NSLog(@"superBounds:%@", NSStringFromCGRect(bounds));
    }
    // 关闭系统约束,使用自动布局
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSMutableDictionary *metrics = [NSMutableDictionary dictionary];
    NSLayoutFormatOptions optionsHs = NSLayoutFormatAlignAllTrailing;
    NSLayoutFormatOptions optionsVs = NSLayoutFormatAlignAllTrailing;
    // 设置约束
    CGFloat left = CGRectGetWidth(bounds)*trans.netFrameLeft/trans.screenScaleX;
    CGFloat top = bounds.origin.y + CGRectGetHeight(bounds)*trans.netFrameTop/trans.screenScaleY;
    CGFloat width = CGRectGetWidth(bounds)*trans.netFrameWidth/trans.screenScaleX;
    CGFloat height = CGRectGetHeight(bounds)*trans.netFrameHeight/trans.screenScaleY;
    [metrics setObject:[NSNumber numberWithFloat:left] forKey:@"left"];
    [metrics setObject:[NSNumber numberWithFloat:top] forKey:@"top"];
    [metrics setObject:[NSNumber numberWithFloat:width] forKey:@"width"];
    [metrics setObject:[NSNumber numberWithFloat:height] forKey:@"height"];
    NSString *formatHs = @"H:|-left-[view(width)]";
    NSString *formatVs = @"V:|-top-[view(height)]";
    // 增加约束
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatHs options:optionsHs metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatVs options:optionsVs metrics:metrics views:views]];
    NSLog(@"%@:%@  %@  %@", view, formatHs, formatVs, metrics);
    NSLog(@"frame:%@", NSStringFromCGSize([view sizeWithConstraints]));
}

- (void)addNetConstraints2WithTrans:(SMTransPercentageFrame *)trans forView:(UIView *)view {
    // frame初始化，默认为父视图bounds
    CGRect bounds = [self frameWithNetType:trans.netType];
    if (CGRectIsEmpty(bounds)) {
        bounds.size = [self sizeWithConstraints];
        NSLog(@"superBounds:%@", NSStringFromCGRect(bounds));
    }
    // 关闭系统约束,使用自动布局
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 横向
    [view addConstraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:(CGRectGetWidth(bounds)*trans.netFrameWidth/trans.screenScaleX)];
    [view addConstraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:((trans.netFrameLeft + trans.netFrameWidth/2)/(trans.screenScaleX/2)) constant:0];
    
    // 纵向
    [view addConstraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:(CGRectGetHeight(bounds)*trans.netFrameHeight/trans.screenScaleY)];
    CGFloat top = bounds.origin.y;
    CGFloat bottom = CGRectGetHeight(self.bounds) - (bounds.origin.y + CGRectGetHeight(bounds));
    CGFloat transEt = top*trans.screenScaleY/CGRectGetHeight(bounds);
    CGFloat transEb = bottom*trans.screenScaleY/CGRectGetHeight(bounds);
    CGFloat transTop = transEt + trans.netFrameTop;
    CGFloat transscreenScaleY = trans.screenScaleY + transEt + transEb;
    [view addConstraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:((transTop + trans.netFrameHeight/2)/(transscreenScaleY/2)) constant:0];
    
    NSLog(@"frame:%@", [view constraints]);

}

- (void)addNetFramesWithTrans:(SMTransPercentageFrame *)trans forView:(UIView *)view {
    CGRect bounds = [self frameWithNetType:trans.netType];
    CGRect frame = bounds;
    frame.origin = CGPointZero;
    frame.origin.x = CGRectGetWidth(bounds)*trans.netFrameLeft/trans.screenScaleX;
    frame.origin.y = bounds.origin.y + CGRectGetHeight(bounds)*trans.netFrameTop/trans.screenScaleY;
    frame.size.width = CGRectGetWidth(bounds)*trans.netFrameWidth/trans.screenScaleX;
    frame.size.height = CGRectGetHeight(bounds)*trans.netFrameHeight/trans.screenScaleY;
    view.frame = frame;
    NSLog(@"frame:%@", NSStringFromCGRect(frame));
}

- (void)addFramesWithTrans:(SMTransPercentageFrame *)trans forView:(UIView *)view {
    // frame初始化，默认为父视图bounds
    CGRect bounds = [self frameWithNetType:trans.netType];
    if (CGRectIsEmpty(bounds)) {
        bounds.size = [self sizeWithConstraints];
        NSLog(@"superBounds:%@", NSStringFromCGRect(bounds));
    }
    CGRect frame = bounds;
    frame.origin = CGPointZero;
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
            frame.origin.y = bounds.origin.y + CGRectGetHeight(bounds)*trans.insetsTop/trans.screenScaleY;
        } else if (!trans.isAutoInsetsBottom) {
            frame.origin.y = bounds.origin.y + CGRectGetHeight(bounds) - CGRectGetHeight(bounds) - CGRectGetHeight(bounds)*trans.insetsBottom/trans.screenScaleY;
        } else {
            // 左右都为自动值 居中
            frame.origin.y = bounds.origin.y + (CGRectGetHeight(bounds) - CGRectGetHeight(bounds))/2;
        }
    } else {
        frame.origin.y = bounds.origin.y + CGRectGetHeight(bounds)*trans.insetsTop/trans.screenScaleY;
        frame.size.height = CGRectGetHeight(bounds) - CGRectGetHeight(bounds)*(trans.insetsTop + trans.insetsBottom)/trans.screenScaleY;
    }
    // 设置子视图的frame
    view.frame = frame;
    NSLog(@"frame:%@", NSStringFromCGRect(frame));
}

#pragma mark - autoLayout
- (void)addConstraintWithAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c {
    NSAssert(self.superview, @"%s:没有父视图", __FUNCTION__);
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    [self.superview addConstraint:constraint];
}

@end
