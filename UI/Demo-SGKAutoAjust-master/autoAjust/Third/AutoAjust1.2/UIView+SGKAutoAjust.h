//
//  UIView+SGKAutoAjust.h
//  用代码实现计算器布局_Masonry
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

/*
 * 请使用时务必将以下代码添加到对应的控制器中
 *
 
 - (void)dealloc{
 // 销毁参照
 [self.view removeRelation];
 // 关闭旋转适配
 [self.view stopAutoAjustOnRotaion];
 }
 
 - (void)viewWillAppear:(BOOL)animated{
 // 自动适配
 [self.view setAutoAjustWithSupderAccordingFrame:SGKScreenFrameIPhone3_5Portrait];
 // 打开旋转适配
 [self.view openAutoAjustOnRotaion];
 }
 
 *
 *
 */



#import <UIKit/UIKit.h>
#import "SGKAutoAjustInstance.h"

@interface UIView (SGKAutoAjust)

// 添加本视图为父视图参照并自动适配,推荐用视图控制器为父视图参照
- (SGKAccordingRelation *)setAutoAjustWithSupderAccordingFrame:(CGRect)frame;

// 添加本视图为父视图参照,需要手动适配
- (SGKAccordingRelation *)setAjustWithSupderAccordingFrame:(CGRect)frame;

// 添加子视图参照,并适配
- (SGKAccordingRelation *)addSubAccordingWithView:(UIView *)view frame:(CGRect)frame;

// 手动适配,在控制器的-viewWillAppear:方法中添加此方法
- (void)autoAjustRelation;

// 移除relation,请在对象销毁前移除relation,否则会造成内存泄漏
- (void)removeRelation;

// 打开旋转自适应
- (void)openAutoAjustOnRotaion;

// 关闭旋转自适应
- (void)stopAutoAjustOnRotaion;

@end
