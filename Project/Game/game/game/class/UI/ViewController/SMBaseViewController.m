//
//  SMBaseViewController.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMBaseViewController.h"

@implementation SMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self loadData];
    [self loadUI];
    [self loadUIData];
    [self loadUIFrame];
}

- (void)loadData {
    // for sub class
}

- (void)loadUI {
    // for sub class
}

- (void)loadUIData {
    // for sub class
}

- (void)loadUIFrame {
    // for sub class
}

@end
