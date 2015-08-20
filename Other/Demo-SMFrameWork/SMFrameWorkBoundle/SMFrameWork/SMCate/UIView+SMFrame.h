//
//  UIView+SMFrame.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

// 部份方法提炼成宏在这里调用
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
#define framePercentage(perH, perV, vbw, vbh, fd, ov) [UIView frameWithPercentageH:perH percentageV:perV viewBounds:CGRectMake(0, 0, vbw, vbh) frameDirectory:fd otherValue:ov]

#define framePercentage2(perH, perV, vt, vf, fd, ov) [UIView frameWithPercentageH:perH percentageV:perV viewText:vt viewFontSize:vf frameDirectory:fd otherValue:ov]

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

#import <UIKit/UIKit.h>

// 显示位置类型
typedef enum{
    // 左下
    WPSeatTypeLeftBottom,
    // 左上
    WPSeatTypeLeftTop,
    // 右上
    WPSeatTypeRightTop,
    // 右下
    WPSeatTypeRightBottom,
    
    // 左中
    WPSeatTypeLeftMiddle,
    // 上中
    WPSeatTypeTopMiddle,
    // 右中
    WPSeatTypeRightMiddle,
    // 下中
    WPSeatTypeBottomMiddle,
    
} WPSeatType;

typedef enum {
    // 垂直方向
    SMFrameDirectoryV   = 1 << 0,
    // 水平方向
    SMFrameDirectoryH   = 1 << 1,
}SMFrameDirectory;

@interface UIView (SMFrame)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGPoint leftTop;

@property (assign, nonatomic) CGPoint rightTop;

@property (assign, nonatomic) CGPoint leftBottom;

@property (assign, nonatomic) CGPoint rightBottom;

@property (assign, nonatomic) CGPoint leftMiddle;

@property (assign, nonatomic) CGPoint rightMiddle;

@property (assign, nonatomic) CGPoint topMiddle;

@property (assign, nonatomic) CGPoint bottomMiddle;

// 屏幕中心x坐标
+ (CGFloat)centerSX;

// 屏幕中心y坐标
+ (CGFloat)centerSY;

/**
 *  根据类型和点设置View位置
 *
 *  @param seatType 设置位置类型
 *  @param point    点
 */
- (void)setFrameWithSeatType:(WPSeatType)seatType point:(CGPoint)point;

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
+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewBounds:(CGRect)viewBounds frameDirectory:(SMFrameDirectory)frameDirectory otherValue:(CGFloat)otherValue NS_AVAILABLE_IOS(7_0);

+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewText:(NSString *)viewText viewFontSize:(double)viewFontSize frameDirectory:(SMFrameDirectory)frameDirectory otherValue:(CGFloat)otherValue NS_AVAILABLE_IOS(7_0);

@end
