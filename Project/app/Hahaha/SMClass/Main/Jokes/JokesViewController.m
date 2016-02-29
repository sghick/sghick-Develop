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
#import "SMNetManager.h"

typedef NS_ENUM(int, kTagForJokesViewControllerView) {
    kTagForJokesViewControllerViewAlertInWifi = 10001,
    kTagForJokesViewControllerViewAlertInOther
};

@interface JokesViewController ()<
    JokeBllDelegate,
    UITableViewDataSource,
    UITableViewDelegate,
    JokeDetailViewControllerDelegate,
    UIAlertViewDelegate >

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) SMTableView *tableView;
@property (strong, nonatomic) UISegmentedControl *segment;
@property (strong, nonatomic) UILabel *unreadNumLabel;

@property (assign, nonatomic) int backCount;
@property (assign, nonatomic) int backPage;

@property (strong, nonatomic) NSArray * dataSource;

@end

static NSString *identifier = @"identifier";

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAutoItem:)];
    
    [self.view addSubview:self.tableView attributePathKey:@"JokesViewController.tableView"];
    [self.view addSubview:self.segment attributePathKey:@"JokesViewController.segment"];
//    [self.view addSubview:self.unreadNumLabel attributePathKey:@"JokesViewController.unreadNumLabel"];
    
//    [self.view showNetLineWithRowAndColoum:CGPointMake(1, 30) lineColor:[UIColor redColor] netType:35 alpha:0.5];
    __weak JokesViewController *weakSelf = self;
    [self.tableView mj_addMJRefreshOperationBlock:^(int page) {
        [weakSelf requestJokesWithCurPage:page];
    } operationType:SMMjOperationTypeDefault refresh:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataFromDBIsRead:self.segment.selectedSegmentIndex];
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
    UIColor *color = joke.isRead?[UIColor grayColor]:[UIColor blackColor];
    cell.textLabel.text = joke.title;
    cell.textLabel.textColor = color;
    cell.detailTextLabel.text = joke.content;
    cell.detailTextLabel.textColor = color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JokeDetailViewController *vc = [[JokeDetailViewController alloc] init];
    SMJoke *joke = self.dataSource[indexPath.row];
    vc.joke = joke;
    vc.delegate = self;
    vc.gravity = YES;
    vc.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - JokeDetailViewControllerDelegate
- (BOOL)jokeDetailViewController:(JokeDetailViewController *)viewController changeToLastWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SMLog(@"到头了！");
        return NO;
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
    SMJoke *joke = self.dataSource[lastIndexPath.row];
    viewController.indexPath = lastIndexPath;
    viewController.joke = joke;
    [UIView transitionWithView:viewController.view duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    } completion:^(BOOL finished) {
        viewController.gravity = YES;
    }];
    return YES;
}

- (BOOL)jokeDetailViewController:(JokeDetailViewController *)viewController changeToNextWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataSource.count - 1) {
        SMLog(@"到最后了！");
        return NO;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    SMJoke *joke = self.dataSource[nextIndexPath.row];
    viewController.indexPath = nextIndexPath;
    viewController.joke = joke;
    [UIView transitionWithView:viewController.view duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    } completion:^(BOOL finished) {
        viewController.gravity = YES;
    }];
    return YES;
}

#pragma mark - action
- (void)segmentAction:(UISegmentedControl *)sender {
    [self loadDataFromDBIsRead:sender.selectedSegmentIndex];
}

- (void)addAutoItem:(UIBarButtonItem *)sender {
    SMNetStatus status = [SMNetManager netStatus];
    if (status == SMNetStatusReachableViaWiFi) {
        self.backPage = (int)[SMUserDefaults integerForKey:kPagesRequest];
        NSString *message = [NSString stringWithFormat:@"当前为wifi环境\n是否要下载之后\n第 %d-%d 页", self.backPage, (self.backPage + 20)];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"不，我摁错了" otherButtonTitles:@"我要从第0页开始", @"是的", nil];
        alert.tag = kTagForJokesViewControllerViewAlertInWifi;
        alert.delegate = self;
        [alert show];
    } else {
        NSString *message = [NSString stringWithFormat:@"当前为非wifi环境，为保护您的流量，请切换至wifi环境下再下载"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        alert.tag = kTagForJokesViewControllerViewAlertInOther;
        alert.delegate = self;
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kTagForJokesViewControllerViewAlertInWifi) {
        switch (buttonIndex) {
            case 0:
                break;
            case 1:{
                self.backPage = 0;
                [SMUserDefaults setInteger:0 forKey:kPagesRequest];
            } break;
            case 2:{
                [self requestJokeListInBackgroundWithPage:self.backPage toPage:(self.backPage + 20)];
                self.backCount = 0;
                self.backPage += 20;
                [SMUserDefaults setInteger:self.backPage forKey:kPagesRequest];
            } break;
            default:
                break;
        }
    }
}

#pragma mark - request/loadData
- (void)requestJokesWithCurPage:(int)curPage {
    [self.bll requestJokeListWithCurPage:curPage];
}

- (void)requestJokeListInBackgroundWithPage:(int)page toPage:(int)toPage {
    [self.bll requestJokeListInBackgroundWithPage:page toPage:toPage];
}

- (void)loadDataFromDBIsRead:(BOOL)isRead {
    self.dataSource = [self.bll searchJokesFromDBIsRead:isRead];
    self.title = SMToString(@"笑话(%zi)", self.dataSource.count);
    [self.tableView reloadData];
}

#pragma mark - JokeBllDelegate
- (void)respondsFaildWithErrorCode:(NSString *)errorCode {
    [self.tableView mj_faildRefresh];
}

- (void)respondsJokesCount:(int)count curPage:(int)curPage {
    SMLog(@"新增 %d 条", count);
    [self.tableView mj_finishedFillDataSource:nil curPage:curPage newDataSource:nil];
    [self loadDataFromDBIsRead:self.segment.selectedSegmentIndex];
}

- (void)respondsJokeListInBackgroundCount:(int)count curPage:(int)curPage {
    self.backCount += count;
    if (curPage == self.backPage - 1) {
        SMLog(@"新增 %d 条", self.backCount);
        [self loadDataFromDBIsRead:self.segment.selectedSegmentIndex];
    }
}

#pragma mark - Getters/Setters
- (JokeBll *)bll {
    if (_bll == nil) {
        JokeBll *bll = [[JokeBll alloc] init];
        bll.delegate = self;
        _bll = bll;
    }
    return _bll;
}

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

- (UILabel *)unreadNumLabel {
    if (!_unreadNumLabel) {
        _unreadNumLabel = [[UILabel alloc] init];
        _unreadNumLabel.backgroundColor = [UIColor clearColor];
        _unreadNumLabel.font = [UIFont systemFontOfSize:10*SMWidthScale];
        _unreadNumLabel.textColor = [UIColor redColor];
        _unreadNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unreadNumLabel;
}

@end
