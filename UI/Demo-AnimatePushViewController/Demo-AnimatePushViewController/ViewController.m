//
//  ViewController.m
//  Demo-AnimatePushViewController
//
//  Created by 丁治文 on 15/7/7.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "ScanPushView.h"
#import "SMViewControllerA.h"
#import "SMViewControllerB.h"

#define BackToMainPage_NotiFication @"BackToMainPage_NotiFication"

@interface ViewController ()<ScanPushViewDelegate>

@property (strong, nonatomic) ScanPushView *scanPushView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    ScanPushView *scanPushView = [[ScanPushView alloc] initWithFrame:self.view.bounds];
    scanPushView.scanPushViewDelegate = self;
    [self.view addSubview:scanPushView];
    self.scanPushView = scanPushView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMainViewNotification:) name:BackToMainPage_NotiFication object:nil];
}

#pragma mark - PushViewDelegate
- (void)scanPushView:(ScanPushView *)scanPushView videoButtonTouched:(UIButton *)videoButton {
    SMViewControllerA *vcA = [[SMViewControllerA alloc] init];
    vcA.pushViewProxy = self.scanPushView;
    [self presentViewController:vcA animated:NO completion:nil];
}

- (void)scanPushView:(ScanPushView *)scanPushView helpButtonTouched:(UIButton *)helpButton {
    SMViewControllerB *vcB = [[SMViewControllerB alloc] init];
    vcB.pushViewProxy = self.scanPushView;
    [self presentViewController:vcB animated:NO completion:nil];
}

- (void)backToMainViewNotification:(NSNotification *)notice {
    [self.scanPushView backToPresentingViewControllerWithTag:TAG_HELP];
}

@end
