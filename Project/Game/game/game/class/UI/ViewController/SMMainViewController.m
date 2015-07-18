//
//  SMMainViewController.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMMainViewController.h"
#import "SMRunViewController.h"

@interface SMMainViewController ()

@property (strong, nonatomic) UIButton *startBtn;

@end

@implementation SMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - SMBaseViewControllerProtocol
- (void)loadData {
    [super loadData];
}

- (void)loadUI {
    [super loadUI];
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
    [startBtn setBackgroundColor:[UIColor cyanColor]];
    [startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    self.startBtn = startBtn;
}

- (void)loadUIData {
    [super loadUIData];
}

- (void)loadUIFrame {
    [super loadUIFrame];
    self.startBtn.frame = frameCenter(200, 40, SMFrameDirectoryH, 100);
}

#pragma mark - action
- (void)startBtnAction:(UIButton *)sender {
    SMRunViewController *runVC = [[SMRunViewController alloc] init];
    [self.navigationController pushViewController:runVC animated:YES];
}


@end
