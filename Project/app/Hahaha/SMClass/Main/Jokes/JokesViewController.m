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

typedef NS_ENUM(NSInteger, JokesType) {
    JokesType1,
    JokesType2,
    JokesType3
};

@interface JokesViewController ()<
JokeBllDelegate,
UITableViewDataSource,
UITableViewDelegate,
JokeDetailViewControllerDelegate
>

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) SMTableView *tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (assign, nonatomic) JokesType jokesType;

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
        [self requestJokesWithCurPage:page];
    } operationType:SMMjOperationTypeDefault refresh:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestJokesWithCurPage:1];
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

#pragma mark - request
- (void)requestJokesWithCurPage:(int)curPage {
    [self.bll requestJokeListWithCurPage:curPage];
}

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
    UIColor *color = nil;
    if (joke.isRead) {
        color = [UIColor grayColor];
    } else {
        color = [UIColor blackColor];
    }
    
    cell.textLabel.text = joke.title;
    cell.textLabel.textColor = color;
    cell.detailTextLabel.text = joke.content;
    cell.detailTextLabel.textColor = color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SMJoke *joke = self.dataSource[indexPath.row];
    JokeDetailViewController *vc = [[JokeDetailViewController alloc] init];
    vc.delegate = self;
    vc.joke = joke;
    vc.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - JokeDetailViewControllerDelegate
- (void)jokeDetailViewController:(JokeDetailViewController *)viewController changeToLastWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SMLog(@"到头了！");
        return;
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
    SMJoke *joke = self.dataSource[lastIndexPath.row];
    JokeDetailViewController *detailVC = [[JokeDetailViewController alloc] init];
    detailVC.delegate = self;
    detailVC.joke = joke;
    detailVC.indexPath = lastIndexPath;
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers insertObject:detailVC atIndex:(viewControllers.count - 1)];
    self.navigationController.viewControllers = viewControllers;
    [viewController.navigationController popViewControllerAnimated:YES];
}

- (void)jokeDetailViewController:(JokeDetailViewController *)viewController changeToNextWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataSource.count - 1) {
        SMLog(@"到最后了！");
        return;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    SMJoke *joke = self.dataSource[nextIndexPath.row];
    JokeDetailViewController *detailVC = [[JokeDetailViewController alloc] init];
    detailVC.delegate = self;
    detailVC.joke = joke;
    detailVC.indexPath = nextIndexPath;
    viewController.title = self.title;
    [viewController.navigationController pushViewController:detailVC animated:YES];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers removeObject:viewController];
    self.navigationController.viewControllers = viewControllers;
}

#pragma mark - bll delegate
- (void)respondsFaildWithErrorCode:(NSString *)errorCode {
    SMLog(@"%@,%@", kLogError, errorCode);
    [self.tableView mj_faildRefresh];
}

- (void)respondsJokeList:(NSArray *)array curPage:(int)curPage {
    SMLog(@"%zi,%zi", self.dataSource.count, curPage);
    [self.tableView mj_finishedFillDataSource:self.dataSource curPage:curPage newDataSource:array];
    [self.tableView reloadData];
}

@end
