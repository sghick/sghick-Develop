//
//  SMRootViewController.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMRootViewController.h"
#import "SMMainViewController.h"

@interface SMRootViewController ()

@end

@implementation SMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gotoMain];
}

- (void)gotoMain {
    SMMainViewController *mainVC = [[SMMainViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:NO];
}

@end
