//
//  PresentView.h
//  AstonMartin
//
//  Created by buding on 15/9/22.
//  Copyright © 2015年 Buding WeiChe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PresentModeBottom,
    PresentModeLeft,
    PresentModeTop,
    PresentModeRight,
    PresentModeCenter
}PresentMode;

@protocol PresentViewDelegate <NSObject>

@optional;
// 点击背景后是否关闭视图，默认关闭
- (BOOL)presentView:(UIView *)view shouldCloseWhenTouched:(UIEvent *)event;

@end

@interface PresentView : UIView

// 当前的显示状态
@property (assign, readonly, nonatomic) BOOL show;
// 内容视图
@property (strong, readonly, nonatomic) UIView *contentView;
// 内容视图的大小
@property (assign, nonatomic) CGRect contentFrame;
// 内容视图的出现位置
@property (assign, nonatomic) PresentMode presentMode;
// 代理
@property (assign, nonatomic) id<PresentViewDelegate> delegate;

/**
 *  创建UI的方法，供子类继承时使用
 */
- (void)createSubview;

/**
 *  设置移动后的frame
 */
- (void)setAnimatedContentFrame:(CGRect)frame;

/**
 *  弹出/隐藏视图
 *
 *  @param show 
 */
- (void)show:(BOOL)show;

- (void)setContentViewBackgroudColor:(UIColor *)color;

@end
