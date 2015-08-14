//
//  JokesViewController.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokesViewController.h"
#import "JokeBll.h"
#import "SMResult.h"
#import "SMJoke.h"
#import "UITableView+SM.h"
#import "JokeDetailViewController.h"

@interface JokesViewController ()<
JokeBllDelegate,
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) SMTableView *tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;

@end

static NSString *identifier = @"identifier";

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JokeBll *bll = [[JokeBll alloc] init];
    bll.delegate = self;
    self.bll = bll;
    
    SMTableView *tableView = [[SMTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setExtraCellLineHidden];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self updateViewConstraints];
    
    self.dataSource = [NSMutableArray array];
    [tableView mj_addMJRefreshOperationBlock:^(int page) {
        [self.bll requestJokeListWithCurPage:page];
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_tableView);
    [UIView setTranslatesAutoresizingMaskIntoConstraintsWithViews:views flag:NO];
    NSDictionary *metrics = @{};
    
    // 横向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 纵向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
}

#pragma mark - action

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    SMJoke *joke = self.dataSource[indexPath.row];
    cell.textLabel.text = joke.author;
    cell.detailTextLabel.text = joke.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SMJoke *joke = self.dataSource[indexPath.row];
    JokeDetailViewController *vc = [[JokeDetailViewController alloc] init];
    vc.joke = joke;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - bll delegate
- (void)respondsFaildWithErrorCode:(NSString *)errorCode {
    SMLog(@"%@,%@", kLogError, errorCode);
    [self.tableView mj_faildRefresh];
}

- (void)respondsJokeList:(NSArray *)array curPage:(int)curPage {
    [self.tableView mj_finishedFillDataSource:self.dataSource curPage:curPage newDataSource:array];
    [self.tableView reloadData];
}

@end
