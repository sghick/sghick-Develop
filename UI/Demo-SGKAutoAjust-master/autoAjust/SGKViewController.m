//
//  SGKViewController.m
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import "SGKViewController.h"
#import "SGKAutoAjust.h"

@interface SGKViewController ()

@end

@implementation SGKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 100, 200)];
    [view1 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view1];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(20, 250, 200, 120)];
    [view2 setBackgroundColor:[UIColor yellowColor]];
    [view1 addSubview:view2];
    
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(50, 40, 100, 120)];
    [view3 setBackgroundColor:[UIColor cyanColor]];
    [view2 addSubview:view3];
}

#pragma mark- AutoAjustAttag
- (void)viewWillAppear:(BOOL)animated{
    // 自动适配
    [self.view setAutoAjustWithSupderAccordingFrame:SGKScreenFrameIPhone4_Portrait];
    // 打开旋转适配
    [self.view openAutoAjustOnRotaion];
}

- (void)viewWillDisappear:(BOOL)animated {
    // 销毁参照
    [self.view removeRelation];
    // 关闭旋转适配
    [self.view stopAutoAjustOnRotaion];
}

@end
