//
//  ViewController.m
//  Demo-WPCircleProgressView
//
//  Created by 丁治文 on 15/6/20.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "ViewController.h"
#import "WPCircleProgressView.h"

#define WPRandomColor [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 无动画显示进度条
    WPCircleProgressView * cpv1 = [self circleProgressViewWithFrame:CGRectMake(10, 30, 100, 100)];
    cpv1.tag = 1001;
    [self.view addSubview:cpv1];
    
    // 动画显示进度条
    WPCircleProgressView * cpv2 = [self circleProgressViewWithFrame:CGRectMake(120, 30, 100, 100)];
    cpv2.tag = 1002;
    [self.view addSubview:cpv2];
    
    // 圆角进度条
    WPCircleProgressView * cpv3 = [self circleProgressViewWithFrame:CGRectMake(230, 30, 100, 100)];
    cpv3.rounded = YES;
    [self.view addSubview:cpv3];
    
    // 渐变色进度条
    WPCircleProgressView * cpv4 = [self circleProgressViewWithFrame:CGRectMake(10, 140, 100, 100)];
    cpv4.gradually = YES;
    [self.view addSubview:cpv4];
    
    // 自定义渐变色进度条
    WPCircleProgressView * cpv5 = [self circleProgressViewWithFrame:CGRectMake(120, 140, 100, 100)];
    cpv5.gradually = YES;
    cpv5.gradientColors = @[(id)WPRandomColor.CGColor, (id)WPRandomColor.CGColor, (id)WPRandomColor.CGColor];
    [self.view addSubview:cpv5];
}

- (void)cpvTapAction:(UITapGestureRecognizer *)tap {
    WPCircleProgressView * tapView = nil;
    if ([tap.view isKindOfClass:[WPCircleProgressView class]]) {
        tapView = (WPCircleProgressView *)tap.view;
        CGFloat randomProgress = arc4random()%10000/10000.0f;
        if (tapView.tag == 1001) {
            [tapView setProgress:randomProgress];
        }
        else {
            [tapView setProgress:randomProgress animated:YES animatedDuration:0.5f];
        }
    }
}

- (WPCircleProgressView *)circleProgressViewWithFrame:(CGRect)rect {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cpvTapAction:)];
    WPCircleProgressView * rtnView = [[WPCircleProgressView alloc] initWithFrame:rect];
    [rtnView setUserInteractionEnabled:YES];
    rtnView.progressTintColor = WPRandomColor;
    rtnView.trackTintColor = [UIColor greenColor];
    rtnView.progress = 1.0f;
    rtnView.pathWidth = arc4random()%20 + 10;
    rtnView.radius = arc4random()%20 + 30;
    [rtnView addGestureRecognizer:tap];
    return rtnView;
}

@end
