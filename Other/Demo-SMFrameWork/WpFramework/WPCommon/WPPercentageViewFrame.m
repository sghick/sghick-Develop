//
//  WPPercentageViewFrame.m
//  WisdomPark
//
//  Created by 丁治文 on 15/3/9.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPPercentageViewFrame.h"

@implementation WPPercentageViewFrame

/**
 *  取得view在屏幕中的位置(view的大小固定可以使用)
 *
 *  @param percentage     位置比例
 *  @param viewBounds     view的大小
 *  @param frameDirectory 相对的方向
 *  @param otherValue     其它值
 *
 *  @return 新的frame
 */
+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewBounds:(CGRect)viewBounds frameDirectory:(int)frameDirectory otherValue:(CGFloat)otherValue{
    // 返回值
    CGRect rtn = CGRectMake(otherValue, otherValue, viewBounds.size.width, viewBounds.size.height);
    // 屏幕bounds
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    // 垂直方向居中
    if (frameDirectoryV & frameDirectory) {
        rtn.origin.y = (screenBounds.size.height - viewBounds.size.height)*percentageV;
    }
    // 水平方向居中
    if (frameDirectoryH & frameDirectory) {
        rtn.origin.x = (screenBounds.size.width - viewBounds.size.width)*percentageH;
    }
    return rtn;
}

+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewText:(NSString *)viewText viewFontSize:(double)viewFontSize frameDirectory:(int)frameDirectory otherValue:(CGFloat)otherValue{
    CGRect bonds = [viewText boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:viewFontSize]} context:nil];
    CGRect rtn = [WPPercentageViewFrame frameWithPercentageH:percentageH percentageV:percentageV viewBounds:bonds frameDirectory:frameDirectory otherValue:otherValue];
    return rtn;
}

@end
