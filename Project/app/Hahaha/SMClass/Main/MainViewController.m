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

@end

static NSString *identifier = @"identifier";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SMButton *jokesBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [jokesBtn setTitle:@"笑话" forState:UIControlStateNormal];
    [jokesBtn addTarget:self action:@selector(jokesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jokesBtn];
    self.jokesBtn = jokesBtn;
    
    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_jokesBtn);
    [UIView setTranslatesAutoresizingMaskIntoConstraintsWithViews:views flag:NO];
    NSDictionary * metrics = @{@"width":[NSNumber numberWithFloat:(SMScreenWidth - 20*SMWidthScale)/1], @"margin":@"10"};
    
    // 横向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_jokesBtn(width)]"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:metrics
                                                                        views:views]];
    // 纵向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_jokesBtn]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
}

#pragma mark - action
- (void)jokesBtnAction:(UIButton *)sender {
    JokesViewController *jokesVC = [[JokesViewController alloc] init];
    [self.navigationController pushViewController:jokesVC animated:YES];
}

@end
