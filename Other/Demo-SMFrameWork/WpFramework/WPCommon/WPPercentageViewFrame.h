//
//  WPPercentageViewFrame.h
//  WisdomPark
//
//  Created by 丁治文 on 15/3/9.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

// 所有方法提炼成宏在这里调用
/**
 *  取得view在屏幕中的位置(view的大小固定可以使用)
 *
 *  @param perH 水平位置比例
 *  @param perV 垂直位置比例
 *  @param vbw view的宽
 *  @param vbh view的高
 *  @param fd  view居中的相对位置
 *  @param ov  另一坐标
 *
 *  @return 新的frame
 */
#define framePercentage(perH, perV, vbw, vbh, fd, ov) [WPPercentageViewFrame frameWithPercentageH:perH percentageV:perV viewBounds:CGRectMake(0, 0, vbw, vbh) frameDirectory:fd otherValue:ov]

#define framePercentage2(perH, perV, vt, vf, fd, ov) [WPPercentageViewFrame frameWithPercentageH:perH percentageV:perV viewText:vt viewFontSize:vf frameDirectory:fd otherValue:ov]

/**
 *  取得view在屏幕中的居中的位置(view的大小固定可以使用)
 *
 *  @param vbw view的宽
 *  @param vbh view的高
 *  @param fd  view居中的相对位置
 *  @param ov  另一坐标
 *
 *  @return 新的frame
 */
#define frameCenter(vbw, vbh, fd, ov) framePercentage(0.5, 0.5, vbw, vbh, fd, ov)

#define frameCenter2(vt, vf, fd, ov) framePercentage2(0.5, 0.5, vt, vf, fd, ov)

#import <Foundation/Foundation.h>
// 垂直方向
#define frameDirectoryV 1<<0
// 水平方向
#define frameDirectoryH 1<<1

@interface WPPercentageViewFrame : NSObject

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
+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewBounds:(CGRect)viewBounds frameDirectory:(int)frameDirectory otherValue:(CGFloat)otherValue;

+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewText:(NSString *)viewText viewFontSize:(double)viewFontSize frameDirectory:(int)frameDirectory otherValue:(CGFloat)otherValue;


@end
