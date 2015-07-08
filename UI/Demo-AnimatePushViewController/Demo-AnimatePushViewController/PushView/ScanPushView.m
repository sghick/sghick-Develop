//
//  ScanPushView.m
//  Demo-AnimatePushViewController
//
//  Created by buding on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "ScanPushView.h"

@interface ScanPushView ()

@property (strong, nonatomic) UIButton *videoButton;
@property (strong, nonatomic) UIButton *helpButton;

@end

@implementation ScanPushView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self UIInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self UIInit];
    }
    return self;
}

- (void)UIInit {
    // 创建UI
    UIButton *videoButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 20, 40, 40)];
    [videoButton addTarget:self action:@selector(videoButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    videoButton.backgroundColor = [UIColor blueColor];
    [self addSubview:videoButton];
    self.videoButton = videoButton;
    
    UIButton *helpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 40, 40)];
    [helpButton addTarget:self action:@selector(helpButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.backgroundColor = [UIColor redColor];
    [self addSubview:helpButton];
    self.helpButton = helpButton;
}

#pragma mark - action
- (void)videoButtonTouched:(UIButton *)sender {
    [self presentingViewControllerAnimatedFromView:self.videoButton color:nil completion:^(BOOL finished) {
        if ([self.scanPushViewDelegate respondsToSelector:@selector(scanPushView:videoButtonTouched:)]) {
            [self.scanPushViewDelegate scanPushView:self videoButtonTouched:self.videoButton];
        }
    }];
}

- (void)helpButtonTouched:(UIButton *)sender {
    [self presentingViewControllerAnimatedFromView:self.helpButton color:nil completion:^(BOOL finished) {
        if ([self.scanPushViewDelegate respondsToSelector:@selector(scanPushView:helpButtonTouched:)]) {
            [self.scanPushViewDelegate scanPushView:self helpButtonTouched:self.helpButton];
        }
    }];
}

#pragma mark - PushView
- (void)backToPresentingViewControllerWithTag:(int)tag {
    switch (tag) {
        case TAG_VIDEO:
            [self backToPresentingViewControllerAtView:self.videoButton color:nil];
            break;
            
        case TAG_HELP:
            [self backToPresentingViewControllerAtView:self.helpButton color:nil];
            break;
            
        default:
            break;
    }
}

@end
