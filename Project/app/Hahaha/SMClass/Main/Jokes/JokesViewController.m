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
UITableViewDelegate,
JokeDetailViewControllerDelegate
>

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) SMTableView *tableView;
@property (strong, nonatomic) UISegmentedControl *segment;
@property (strong, nonatomic) NSArray * dataSource;

@end

static NSString *identifier = @"identifier";

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JokeBll *bll = [[JokeBll alloc] init];
    bll.delegate = self;
    self.bll = bll;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segment];
    [self updateViewConstraints];
    
    [self.tableView mj_addMJRefreshOperationBlock:^(int page) {
        [self requestJokesWithCurPage:page];
    } operationType:SMMjOperationTypeDefault refresh:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataFromDBIsRead:self.segment.selectedSegmentIndex];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_segment, _tableView);
    [UIView setTranslatesAutoresizingMaskIntoConstraintsWithViews:views flag:NO];
    NSDictionary *metrics = @{
                              @"top":SMToString(@"%f", 64.0f),
                              @"segHeight":SMToString(@"%f", 30.0f)
                              };
    
    // tableView横向
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // tableView纵向
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-segHeight-[_tableView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 横向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_segment]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 纵向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_segment(segHeight)]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
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

#pragma mark - action
- (void)segmentAction:(UISegmentedControl *)sender {
    [self loadDataFromDBIsRead:sender.selectedSegmentIndex];
}

#pragma mark - request/loadData
- (void)requestJokesWithCurPage:(int)curPage {
    [self.bll requestJokeListWithCurPage:curPage];
}

- (void)loadDataFromDBIsRead:(BOOL)isRead {
    self.dataSource = [self.bll searchJokesFromDBIsRead:isRead];
    [self.tableView reloadData];
}

#pragma mark - bll delegate
- (void)respondsFaildWithErrorCode:(NSString *)errorCode {
    [self.tableView mj_faildRefresh];
}

- (void)respondsJokesCount:(int)count curPage:(int)curPage {
    SMLog(@"新增 %d 条", count);
    [self.tableView mj_finishedFillDataSource:nil curPage:curPage newDataSource:nil];
    [self loadDataFromDBIsRead:self.segment.selectedSegmentIndex];
}

#pragma mark - UI getter/setter
- (SMTableView *)tableView {
    if (!_tableView) {
        _tableView = [[SMTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setExtraCellLineHidden];
    }
    return _tableView;
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"未读", @"已读"]];
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = [UIColor blueColor];
        _segment.backgroundColor = [UIColor whiteColor];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

@end
