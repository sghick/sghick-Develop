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
    [self strokeSubviews];
}

- (void)strokeSubviews {
    [self.view addSubview:self.jokesBtn attributePathKey:@"MainViewController.btn1"];
    [self.view addSubview:self.movesBtn attributePathKey:@"MainViewController.btn2"];
}

#pragma mark - action
- (void)jokesBtnAction:(UIButton *)sender {
    JokesViewController *jokesVC = [[JokesViewController alloc] init];
    jokesVC.title = sender.titleLabel.text;
    [self.navigationController pushViewController:jokesVC animated:YES];
}

- (void)movesBtnAction:(UIButton *)sender {
    
}

#pragma mark - getters/setters
- (SMButton *)jokesBtn {
    if (_jokesBtn == nil) {
        SMButton *jokesBtn = [SMButton buttonWithType:UIButtonTypeSystem];
        [jokesBtn setTitle:@"笑话" forState:UIControlStateNormal];
        [jokesBtn addTarget:self action:@selector(jokesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _jokesBtn = jokesBtn;
    }
    return _jokesBtn;
}

- (SMButton *)movesBtn {
    if (_movesBtn == nil) {
        SMButton *movesBtn = [SMButton buttonWithType:UIButtonTypeSystem];
        [movesBtn setTitle:@"电影" forState:UIControlStateNormal];
        [movesBtn addTarget:self action:@selector(movesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _movesBtn = movesBtn;
    }
    return _movesBtn;
}

@end
