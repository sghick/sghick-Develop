//
//  WPCircleProgressView.h
//  WisdomPark
//
//  Created by 丁治文 on 15/3/12.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPCircleProgressView : UIView

// 路径颜色
@property(strong, nonatomic) UIColor *trackTintColor;
// 进度条颜色
@property(strong, nonatomic) UIColor *progressTintColor;
// 进度
@property (assign, nonatomic) CGFloat progress;
// 起点弧度 M_PI
@property (assign, nonatomic) CGFloat startRadians;
// 环的宽度
@property (assign, nonatomic) CGFloat pathWidth;
// 是否设置圆角
@property (assign, nonatomic) BOOL rounded;
// 是否设置渐变色
@property (assign, nonatomic) BOOL gradually;
// 渐变色 (id)[UIColor greenColor].CGColor
@property (strong, nonatomic) NSArray * gradientColors;
// 四周的边距
@property (assign, nonatomic) CGFloat margin;
// 半径
@property (assign, nonatomic) CGFloat radius;

/**
 *  不带动画设置进度
 *
 *  @param progress 进度
 */
- (void)setProgress:(CGFloat)progress;

/**
 *  设置进度
 *
 *  @param progress         进度
 *  @param animated         是否动画
 *  @param animatedDuration 动画时间戳
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated animatedDuration:(CGFloat)animatedDuration;

/**
 *  取到当前进度的圆上的点
 *
 *  @param progress 进度
 *
 *  @return 圆上的点
 */
- (CGPoint)pointWithProgress:(CGFloat)progress;

/**
 *  取到当前进度的圆上的点
 *
 *  @param progress 进度
 *  @param radius   圆的半径
 *
 *  @return 取到当前进度的圆上的点
 */
- (CGPoint)pointWithProgress:(CGFloat)progress radius:(CGFloat)radius;

@end
