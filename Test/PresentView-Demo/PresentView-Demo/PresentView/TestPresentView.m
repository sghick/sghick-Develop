//
//  TestPresentView.m
//  PresentView-Demo
//
//  Created by 丁治文 on 15/10/13.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "TestPresentView.h"

@interface TestPresentView()

@end

@implementation TestPresentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.backHexColor = 0x333333;
    self.backColorAlpha = 0.0f;
    self.backColorPresentAlpha = 0.6f;
    self.contentView.backgroundColor = [UIColor redColor];
}

- (void)show:(BOOL)show withContentHeight:(CGFloat)contentHeight {
    CGFloat headHeight = 50;
    self.contentFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - headHeight, CGRectGetWidth(self.bounds), contentHeight + headHeight);
    self.contentPresentFrame = CGRectMake(0, CGRectGetHeight(self.bounds) - contentHeight - headHeight, CGRectGetWidth(self.bounds), contentHeight + headHeight);
    [self show:show];
}

@end
