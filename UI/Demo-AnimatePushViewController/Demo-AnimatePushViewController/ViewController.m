//
//  ViewController.m
//  Demo-AnimatePushViewController
//
//  Created by 丁治文 on 15/7/7.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "PushButton.h"
#import "SMViewControllerA.h"


@interface ViewController ()

@property (strong, nonatomic) UIButton *pushButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 20, 40, 40)];
    pushButton.backgroundColor = [UIColor redColor];
    [pushButton addTarget:self action:@selector(pushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    self.pushButton = pushButton;
}

- (void)viewWillAppear:(BOOL)animated {
    UIViewController *vcA = self.presentedViewController;
    [UIView animateWithDuration:1.0f animations:^{
        vcA.view.frame = self.pushButton.frame;
    }];
}

- (void)pushButtonAction:(PushButton *)sender {
    SMViewControllerA *vcA = [[SMViewControllerA alloc] init];
    [self presentViewController:vcA animated:YES completion:^{
        vcA.view.frame = self.view.bounds;
    }];
}


@end
