//
//  PresentView.m
//  AstonMartin
//
//  Created by buding on 15/9/22.
//  Copyright © 2015年 Buding WeiChe. All rights reserved.
//

#import "PresentView.h"

@implementation PresentView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    // 设置背景view
    [self setBackgroundColor:UIColorFromHEXWithAlpha(0xffffff, 0.0f)];
    // 设置内容view
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)*(1-0.45) , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.45)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_contentView];
        // 保存移动前的位置
        _contentFrame = _contentView.frame;
        // 设置默认移动方向
        [self setPresentMode:PresentModeBottom];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    BOOL isClose = YES;
    // 获取触摸屏的手指
    CGPoint location = [[touches anyObject] locationInView:self];
    // 判断是点击了contentView以外的地方
    if (!CGRectContainsPoint(_contentView.frame, location)) {
        if ([self.delegate respondsToSelector:@selector(presentView:shouldCloseWhenTouched:)]) {
            isClose = [self.delegate presentView:self shouldCloseWhenTouched:event];
        }
        [self show:!isClose];
    }
}

- (void)setContentFrame:(CGRect)contentFrame {
    _contentFrame = contentFrame;
    [_contentView setFrame:contentFrame];
    self.presentMode = _presentMode;
}

- (void)setPresentMode:(PresentMode)presentMode {
    _presentMode = presentMode;
    CGRect frame = _contentFrame;
    switch (presentMode) {
        case PresentModeBottom:{
            frame.origin.y = self.frame.origin.y + CGRectGetHeight(self.frame);
            [_contentView setFrame:frame];
        } break;
        case PresentModeLeft:{
            frame.origin.x = self.frame.origin.x - CGRectGetWidth(frame);
            [_contentView setFrame:frame];
        } break;
        case PresentModeTop:{
            frame.origin.y = self.frame.origin.y - CGRectGetHeight(frame);
            [_contentView setFrame:frame];
        } break;
        case PresentModeRight:{
            frame.origin.x = self.frame.origin.x + CGRectGetWidth(self.frame);
            [_contentView setFrame:frame];
        } break;
        case PresentModeCenter:{
            _contentView.center = self.center;
        } break;
        default:
            break;
    }
}

- (void)show:(BOOL)show {
    NSAssert(self.superview, @"%@：没有父视图", self);
    if (_show != show) {
        _show = show;
        CGFloat alpha = 0.0f;
        if (show) {
            alpha = 0.4f;
        }
        // 保存移动前frame
        CGRect temp = _contentView.frame;
        [UIView animateWithDuration:0.2f animations:^{
            [_contentView setFrame:_contentFrame];
            // 刷新
            _contentFrame = temp;
            [self setBackgroundColor:UIColorFromHEXWithAlpha(0xffffff, alpha)];
        } completion:^(BOOL finished) {
            if (show) {
                [self.superview bringSubviewToFront:self];
            } else {
                [self.superview sendSubviewToBack:self];
            }
        }];
    }
}

- (void)setAnimatedContentFrame:(CGRect)frame{
    _contentView.frame = frame;
}

- (void)setContentViewBackgroudColor:(UIColor *)color{
    [_contentView setBackgroundColor:color];
}

@end
