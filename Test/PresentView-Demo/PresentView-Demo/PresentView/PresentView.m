//
//  PresentView.m
//  PresentView-Demo
//
//  Created by 丁治文 on 15/10/13.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "PresentView.h"

//16进制转成color 带alpha
#define HexColorWithAlpha(hexColor,a) (RGBColorWithAlpha(((hexColor & 0xFF0000) >> 16), ((hexColor & 0xFF00) >> 8), (hexColor & 0xFF), a))
//16进制转成color
#define HexColor(hexColor) (HexColorWithAlpha(hexColor, 1.0))
// RGB颜色
#define RGBColorWithAlpha(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
// RGB颜色
#define RGBColor(r,g,b) (RGBColorWithAlpha(r,g,b,1.0))

@implementation PresentView

- (instancetype)init {
    NSAssert(NO, @"请用initWithFrame方法初始化");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)*(1-0.45) , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.45)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        _contentView = contentView;
        
        // default
        _show = YES;
    }
    return self;
}

- (void)present:(BOOL)present {
    if (present) {
        self.contentView.frame = self.contentPresentFrame;
    } else {
        self.contentView.frame = self.contentFrame;
    }
}

- (void)show:(BOOL)show {
    [self show:show withDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    } completion:^(BOOL finished) {
    }];
}

- (void)show:(BOOL)show withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    if (_show != show) {
        _show = show;
        if (show) {
            self.contentView.frame = self.contentFrame;
            [UIView animateWithDuration:duration delay:delay options:options animations:^{
                self.contentView.frame = self.contentPresentFrame;
                self.backgroundColor = HexColorWithAlpha(self.backHexColor, self.backColorPresentAlpha);
                self.userInteractionEnabled = YES;
                if (animations) {
                    animations();
                }
            } completion:^(BOOL finished) {
                if (completion) {
                    completion(finished);
                }
            }];
        } else {
            self.contentView.frame = self.contentPresentFrame;
            [UIView animateWithDuration:duration delay:delay options:options animations:^{
                self.contentView.frame = self.contentFrame;
                if (animations) {
                    animations();
                }
            } completion:^(BOOL finished) {
                self.backgroundColor = HexColorWithAlpha(self.backHexColor, self.backColorAlpha);
                self.userInteractionEnabled = NO;
                if (completion) {
                    completion(finished);
                }
            }];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    BOOL shouldClose = YES;
    // 获取触摸屏的手指
    CGPoint location = [sender locationInView:self];
    // 判断是点击了contentView以外的地方
    BOOL atContentView = CGRectContainsPoint(self.contentView.frame, location);
    if ([self.delegate respondsToSelector:@selector(presentView:shouldCloseWhenTouchedAtContentView:)]) {
        shouldClose = [self.delegate presentView:self shouldCloseWhenTouchedAtContentView:atContentView];
    }
    if (shouldClose) {
        [self show:NO];
    }
}

#pragma mark - getter/setter
- (void)setContentFrame:(CGRect)contentFrame {
    _contentFrame = contentFrame;
    self.contentView.frame = contentFrame;
}

- (void)setContentPresentFrame:(CGRect)contentPresentFrame {
    _contentPresentFrame = contentPresentFrame;
}

@end
