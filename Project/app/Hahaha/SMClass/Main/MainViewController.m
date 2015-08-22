//
//  MainViewController.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "MainViewController.h"
#import "JokesViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) SMButton *jokesBtn;
@property (strong, nonatomic) SMButton *movesBtn;

@end

static NSString *identifier = @"identifier";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文子娱乐圈";
    
    SMButton *jokesBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [jokesBtn setTitle:@"笑话" forState:UIControlStateNormal];
    [jokesBtn addTarget:self action:@selector(jokesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jokesBtn attributePathKey:@"MainViewController.btn1"];
    self.jokesBtn = jokesBtn;
    
    SMButton *movesBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [movesBtn setTitle:@"电影" forState:UIControlStateNormal];
    [movesBtn addTarget:self action:@selector(movesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:movesBtn attributePathKey:@"MainViewController.btn2"];
    self.movesBtn = movesBtn;
}

#pragma mark - action
- (void)jokesBtnAction:(UIButton *)sender {
    JokesViewController *jokesVC = [[JokesViewController alloc] init];
    jokesVC.title = sender.titleLabel.text;
    [self.navigationController pushViewController:jokesVC animated:YES];
}

- (void)movesBtnAction:(UIButton *)sender {
    
}

@end
