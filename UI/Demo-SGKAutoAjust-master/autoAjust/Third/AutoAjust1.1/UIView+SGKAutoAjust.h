//
//  UIView+SGKAutoAjust.h
//  用代码实现计算器布局_Masonry
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

/*
 * 请使用时务必将以下三句加在对应的控制器中
 *
 
#pragma mark- AutoAjustAttag
 - (void)dealloc{
 // 销毁参照
 [self.view removeRelation];
 }
 
 - (void)viewWillAppear:(BOOL)animated{
 // 自动适配
 [self.view setAutoAjustWithSupderAccordingFrame:SGKScreenFrameIPhone3_5Portrait];
 }
 
 - (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 // 手动旋转适配
 [self.view autoAjustRelationWithInterfaceOrientation:toInterfaceOrientation];
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

// 旋转适配,在控制器的-willAnimateRotationToInterfaceOrientation:方法中添加此方法
- (void)autoAjustRelationWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

// 移除relation,请在对象销毁前移除relation,否则会造成内存泄漏
- (void)removeRelation;

@end
