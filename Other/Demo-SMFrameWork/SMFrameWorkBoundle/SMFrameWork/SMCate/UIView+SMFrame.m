//
//  UIView+SMFrame.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "UIView+SMFrame.h"

@implementation UIView (SMFrame)

- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)leftTop{
    return CGPointMake(self.left, self.top);
}
- (void)setLeftTop:(CGPoint)leftTop{
    self.left = leftTop.x;
    self.top = leftTop.y;
}

- (CGPoint)rightTop{
    return CGPointMake(self.right, self.top);
}
- (void)setRightTop:(CGPoint)rightTop{
    self.right = rightTop.x;
    self.top = rightTop.y;
}

- (CGPoint)leftBottom{
    return CGPointMake(self.left, self.bottom);
}
- (void)setLeftBottom:(CGPoint)leftBottom{
    self.left = leftBottom.x;
    self.bottom = leftBottom.y;
}

- (CGPoint)rightBottom{
    return CGPointMake(self.right, self.bottom);
}
- (void)setRightBottom:(CGPoint)rightBottom{
    self.right = rightBottom.x;
    self.bottom = rightBottom.y;
}

- (CGPoint)leftMiddle{
    return CGPointMake(self.left, self.centerX);
}
- (void)setLeftMiddle:(CGPoint)leftMiddle{
    self.left = leftMiddle.x;
    self.centerX = leftMiddle.y;
}

- (CGPoint)rightMiddle{
    return CGPointMake(self.right, self.centerX);
}
- (void)setRightMiddle:(CGPoint)rightMiddle{
    self.right = rightMiddle.x;
    self.centerX = rightMiddle.y;
}

- (CGPoint)topMiddle{
    return CGPointMake(self.centerY, self.top);
}
- (void)setTopMiddle:(CGPoint)topMiddle{
    self.centerY = topMiddle.x;
    self.top = topMiddle.y;
}

- (CGPoint)bottomMiddle{
    return CGPointMake(self.centerY, self.bottom);
}
- (void)setBottomMiddle:(CGPoint)bottomMiddle{
    self.centerY = bottomMiddle.x;
    self.bottom = bottomMiddle.y;
}

// 屏幕中心x坐标
+ (CGFloat)centerSX{
    return [UIScreen mainScreen].bounds.size.width/2;
}

// 屏幕中心y坐标
+ (CGFloat)centerSY{
    return [UIScreen mainScreen].bounds.size.height/2;
}

/**
 *  根据类型和点设置View位置
 *
 *  @param seatType 设置位置类型
 *  @param point    点
 */
- (void)setFrameWithSeatType:(WPSeatType)seatType point:(CGPoint)point{
    switch (seatType) {
        case WPSeatTypeRightTop:
            self.rightTop = point;
            break;
        case WPSeatTypeRightBottom:
            self.rightBottom = point;
            break;
        case WPSeatTypeLeftBottom:
            self.leftBottom = point;
            break;
        case WPSeatTypeLeftTop:
            self.leftTop = point;
            break;
        default:
            break;
    }
}

+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewBounds:(CGRect)viewBounds frameDirectory:(SMFrameDirectory)frameDirectory otherValue:(CGFloat)otherValue{
    // 返回值
    CGRect rtn = CGRectMake(otherValue, otherValue, viewBounds.size.width, viewBounds.size.height);
    // 屏幕bounds
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    // 垂直方向居中
    if (SMFrameDirectoryV & frameDirectory) {
        rtn.origin.y = (screenBounds.size.height - viewBounds.size.height)*percentageV;
    }
    // 水平方向居中
    if (SMFrameDirectoryH & frameDirectory) {
        rtn.origin.x = (screenBounds.size.width - viewBounds.size.width)*percentageH;
    }
    return rtn;
}

+ (CGRect)frameWithPercentageH:(double)percentageH percentageV:(double)percentageV viewText:(NSString *)viewText viewFontSize:(double)viewFontSize frameDirectory:(SMFrameDirectory)frameDirectory otherValue:(CGFloat)otherValue{
    CGRect bonds = [viewText boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:viewFontSize]} context:nil];
    CGRect rtn = [UIView frameWithPercentageH:percentageH percentageV:percentageV viewBounds:bonds frameDirectory:frameDirectory otherValue:otherValue];
    return rtn;
}

@end
