//
//  PresentView.h
//  PresentView-Demo
//
//  Created by 丁治文 on 15/10/13.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PresentView;
@protocol PresentViewDelegate <NSObject>

@optional;
// 点击背景后是否关闭视图，默认关闭
- (BOOL)presentView:(PresentView *)view shouldCloseWhenTouchedAtContentView:(BOOL)atContentView;

@end

@interface PresentView : UIView

// 当前的显示状态
@property (assign, nonatomic, readonly) BOOL show;
// 内容视图
@property (strong, nonatomic, readonly) UIView *contentView;
// 内容视图显示前
@property (assign, nonatomic) CGRect contentFrame;
// 内容视图显示时
@property (assign, nonatomic) CGRect contentPresentFrame;

// 背景颜色16进制值
@property (assign, nonatomic) NSInteger backHexColor;
// 背景显示前
@property (assign, nonatomic) CGFloat backColorAlpha;
// 背景显示时
@property (assign, nonatomic) CGFloat backColorPresentAlpha;

// 代理
@property (assign, nonatomic) id<PresentViewDelegate> delegate;

- (void)present:(BOOL)present;
- (void)show:(BOOL)show;
- (void)show:(BOOL)show withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

@end

