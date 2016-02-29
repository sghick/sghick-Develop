//
//  SMAttributiesModel.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#define cScreenWidth        [UIScreen mainScreen].bounds.size.width
#define cScreenHeight       [UIScreen mainScreen].bounds.size.height
//获取屏幕宽比例(curScale = 320.0f 相对iPhone5s的)
#define cWidthScale         (cScreenWidth/320.0f)
//获取屏幕高比例(curScale = 568.0f 相对iPhone5s的)
#define cHeightScale        (cScreenHeight/568.0f)

#define cToString(a...)     ([NSString stringWithFormat:a])
#define cToFloat(a)         (((NSString *)(a)).floatValue)
// 自动符
#define cAuto               @"-"
// 使用比例宽,使用scale中的值
#define cScaleX             @"x"
// 使用比例高,使用scale中的值
#define cScaleY             @"y"
// 逗号分隔符
#define cPartComma          @","

#import "SMAttributiesModel.h"

@implementation SMPercentageFrame
@end

//@implementation SMRealFrame
//@end

@implementation SMTransPercentageFrame
+ (SMTransPercentageFrame *)transWithPercentageFrame:(SMPercentageFrame *)percentageFrame pathKey:(NSString *)pathKey {
    NSMutableArray *errors = [NSMutableArray array];
    SMTransPercentageFrame *trans = [[SMTransPercentageFrame alloc] init];
    // useFrame
    if (percentageFrame.useFrame) {
        if ([percentageFrame.useFrame isEqualToString:cAuto]) {
            trans.useFrame = YES;
        } else {
            trans.useFrame = percentageFrame.useFrame.boolValue;
        }
    } else {
        trans.useFrame = NO;
    }
    // screenScale
    NSArray *partScreenScale = [percentageFrame.screenScale componentsSeparatedByString:cPartComma];
    if (partScreenScale && partScreenScale.count != 2) {
        [errors addObject:cToString(@"pathKey:%@ percentageFrame.screenScale格式错误,正确格式:\"-,-\"", pathKey)];
    } else if (partScreenScale) {
        if (![partScreenScale[0] isEqualToString:cAuto]) {
            trans.screenScaleX = cToFloat(partScreenScale[0]);
            trans.isAutoScreenScaleX = NO;
        } else {
            trans.screenScaleX = cScreenWidth;
            trans.isAutoScreenScaleX = YES;
        }
        if (![partScreenScale[1] isEqualToString:cAuto]) {
            trans.screenScaleY = cToFloat(partScreenScale[1]);
            trans.isAutoScreenScaleY = NO;
        } else {
            trans.screenScaleY = cScreenHeight;
            trans.isAutoScreenScaleY = YES;
        }
    } else {
        trans.screenScaleX = cScreenWidth;
        trans.isAutoScreenScaleX = YES;
        trans.screenScaleY = cScreenHeight;
        trans.isAutoScreenScaleY = YES;
    }
    // netType
    if (percentageFrame.netType) {
        trans.netType = percentageFrame.netType.intValue;
    } else {
        trans.netType = 0;
    }
    // netFrame 如果些项不为空，以下的属性失效
    NSArray *partNetFrame = [percentageFrame.netFrame componentsSeparatedByString:cPartComma];
    if (partNetFrame && partNetFrame.count != 4) {
        [errors addObject:cToString(@"pathKey:%@ percentageFrame.netFrame格式错误,正确格式:\"?,?,?,?\"", pathKey)];
    } else if (partNetFrame) {
        trans.useNetFrame = YES;
        trans.netFrameLeft = cToFloat(partNetFrame[0]);
        trans.netFrameTop = cToFloat(partNetFrame[1]);
        trans.netFrameWidth = cToFloat(partNetFrame[2]);
        trans.netFrameHeight = cToFloat(partNetFrame[3]);
        return trans;
    }
    // scale
    NSArray *partScale = [percentageFrame.scale componentsSeparatedByString:cPartComma];
    if (partScale && partScale.count != 2) {
        [errors addObject:cToString(@"pathKey:%@ percentageFrame.scale格式错误,正确格式:\"-,-\"", pathKey)];
    } else if (partScale) {
        if (![partScale[0] isEqualToString:cAuto]) {
            trans.scaleX = cToFloat(partScale[0]);
            trans.isAutoScaleX = NO;
        } else {
            trans.scaleX = cWidthScale;
            trans.isAutoScaleX = YES;
        }
        if (![partScale[1] isEqualToString:cAuto]) {
            trans.scaleY = cToFloat(partScale[1]);
            trans.isAutoScaleY = NO;
        } else {
            trans.scaleY = cHeightScale;
            trans.isAutoScaleY = YES;
        }
    } else {
        trans.scaleX = cWidthScale;
        trans.isAutoScaleX = YES;
        trans.scaleY = cHeightScale;
        trans.isAutoScaleY = YES;
    }
    // insets
    NSArray *partInsets = [percentageFrame.insets componentsSeparatedByString:cPartComma];
    if (partInsets && partInsets.count != 4) {
        [errors addObject:cToString(@"pathKey:%@ percentageFrame.insets格式错误,正确格式:\"-,-,-,-\"", pathKey)];
    } else if (partInsets) {
        if (![partInsets[0] isEqualToString:cAuto]) {
            trans.isAutoInsetsTop = NO;
            trans.insetsTop = cToFloat(partInsets[0]);
            if ([partInsets[0] rangeOfString:cScaleX].location != NSNotFound) {
                trans.insetsTop *= trans.scaleX;
            }
            if ([partInsets[0] rangeOfString:cScaleY].location != NSNotFound) {
                trans.insetsTop *= trans.scaleY;
            }
        } else {
            trans.isAutoInsetsTop = YES;
            trans.insetsTop = 0;
        }
        if (![partInsets[1] isEqualToString:cAuto]) {
            trans.isAutoInsetsLeft = NO;
            trans.insetsLeft = cToFloat(partInsets[1]);
            if ([partInsets[1] rangeOfString:cScaleX].location != NSNotFound) {
                trans.insetsLeft *= trans.scaleX;
            }
            if ([partInsets[1] rangeOfString:cScaleY].location != NSNotFound) {
                trans.insetsLeft *= trans.scaleY;
            }
        } else {
            trans.isAutoInsetsLeft = YES;
            trans.insetsLeft = 0;
        }
        if (![partInsets[2] isEqualToString:cAuto]) {
            trans.isAutoInsetsBottom = NO;
            trans.insetsBottom = cToFloat(partInsets[2]);
            if ([partInsets[2] rangeOfString:cScaleX].location != NSNotFound) {
                trans.insetsBottom *= trans.scaleX;
            }
            if ([partInsets[2] rangeOfString:cScaleY].location != NSNotFound) {
                trans.insetsBottom *= trans.scaleY;
            }
        } else {
            trans.isAutoInsetsBottom = YES;
            trans.insetsBottom = 0;
        }
        if (![partInsets[3] isEqualToString:cAuto]) {
            trans.isAutoInsetsRight = NO;
            trans.insetsRight = cToFloat(partInsets[3]);
            if ([partInsets[3] rangeOfString:cScaleX].location != NSNotFound) {
                trans.insetsRight *= trans.scaleX;
            }
            if ([partInsets[3] rangeOfString:cScaleY].location != NSNotFound) {
                trans.insetsRight *= trans.scaleY;
            }
        } else {
            trans.isAutoInsetsRight = YES;
            trans.insetsRight = 0;
        }
    } else {
        trans.isAutoInsetsTop = YES;
        trans.insetsRight = 0;
        trans.isAutoInsetsLeft = YES;
        trans.insetsRight = 0;
        trans.isAutoInsetsBottom = YES;
        trans.insetsRight = 0;
        trans.isAutoInsetsRight = YES;
        trans.insetsRight = 0;
    }
    // size
    trans.width = 0;
    trans.height = 0;
    NSArray *partSize = [percentageFrame.size componentsSeparatedByString:cPartComma];
    if (partSize && partSize.count != 2) {
        [errors addObject:cToString(@"pathKey:%@ percentageFrame.size格式错误,正确格式:\"-,-\"", pathKey)];
    } else if (partSize) {
        if ([partSize[0] isEqualToString:cAuto]) {
            trans.isAutoWidth = YES;
            trans.width = 0;
        } else {
            trans.isAutoWidth = NO;
            trans.width = cToFloat(partSize[0]);
            if ([partSize[0] rangeOfString:cScaleX].location != NSNotFound) {
                trans.width *= trans.scaleX;
            }
            if ([partSize[0] rangeOfString:cScaleY].location != NSNotFound) {
                trans.width *= trans.scaleY;
            }
        }
        if ([partSize[1] isEqualToString:cAuto]) {
            trans.isAutoHeight = YES;
            trans.height = 0;
        } else {
            trans.isAutoHeight = NO;
            trans.height = cToFloat(partSize[1]);
            if ([partSize[1] rangeOfString:cScaleX].location != NSNotFound) {
                trans.height *= trans.scaleX;
            }
            if ([partSize[1] rangeOfString:cScaleY].location != NSNotFound) {
                trans.height *= trans.scaleY;
            }
        }
    } else {
        trans.isAutoWidth = YES;
        trans.width = 0;
        trans.isAutoHeight = YES;
        trans.height = 0;
    }
    return trans;
}
@end

