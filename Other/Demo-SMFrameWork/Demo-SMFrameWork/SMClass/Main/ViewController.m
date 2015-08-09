//
//  ViewController.m
//  Demo-SMFrameWork
//
//  Created by buding on 15/8/3.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "ViewController.h"
#import "SampleBll.h"
#import "SMResult.h"
#import "SMJoke.h"
#import "UITableView+SM.h"

@interface ViewController () <
SampleBllDelegate,
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) SampleBll *bll;

@property (strong, nonatomic) SMButton *testGetBtn;
@property (strong, nonatomic) SMButton *testPostBtn;
@property (strong, nonatomic) SMButton *testFileBtn;
@property (strong, nonatomic) SMButton *testDBBtn;
@property (strong, nonatomic) SMButton *testJsonBtn;

@property (strong, nonatomic) SMTableView *tableView;
@property (strong, nonatomic) NSArray * dataSource;

@end

static NSString *identifier = @"identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SampleBll *bll = [[SampleBll alloc] init];
    bll.delegate = self;
    self.bll = bll;
    
    SMButton *testGetBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testGetBtn addTarget:self action:@selector(testGetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [testGetBtn setTitle:@"Get" forState:UIControlStateNormal];
    [self.view addSubview:testGetBtn];
    self.testGetBtn = testGetBtn;
    
    SMButton *testPostBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testPostBtn addTarget:self action:@selector(testPostBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [testPostBtn setTitle:@"Post" forState:UIControlStateNormal];
    [self.view addSubview:testPostBtn];
    self.testPostBtn = testPostBtn;
    
    SMButton *testFileBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testFileBtn addTarget:self action:@selector(testFileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [testFileBtn setTitle:@"File" forState:UIControlStateNormal];
    [self.view addSubview:testFileBtn];
    self.testFileBtn = testFileBtn;
    
    SMButton *testDBBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testDBBtn addTarget:self action:@selector(testDBBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [testDBBtn setTitle:@"DB" forState:UIControlStateNormal];
    [self.view addSubview:testDBBtn];
    self.testDBBtn = testDBBtn;
    
    SMButton *testJsonBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testJsonBtn addTarget:self action:@selector(testJsonBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [testJsonBtn setTitle:@"Json" forState:UIControlStateNormal];
    [self.view addSubview:testJsonBtn];
    self.testJsonBtn = testJsonBtn;
    
    SMTableView *tableView = [[SMTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setExtraCellLineHidden];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_testGetBtn, _testPostBtn, _testFileBtn, _testDBBtn, _testJsonBtn, _tableView);
    [UIView setTranslatesAutoresizingMaskIntoConstraintsWithViews:views flag:NO];
    NSDictionary * metrics = @{@"width":[NSNumber numberWithFloat:(SMScreenWidth - 20*SMWidthScale)/5], @"margin":@"10"};
    
    // 横向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_testGetBtn(width)][_testPostBtn(width)][_testFileBtn(width)][_testDBBtn(width)][_testJsonBtn(width)]"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:metrics
                                                                        views:views]];
    // 横向2
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 纵向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_testGetBtn][_tableView]|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
}

#pragma mark - action
- (void)testGetBtnAction:(UIButton *)sender {
    [self.bll requestGetTestDataWithParam:nil];
}

- (void)testPostBtnAction:(UIButton *)sender {
    [self.bll requestPostTestDataWithParam:nil];
}

- (void)testFileBtnAction:(UIButton *)sender {
    [self.bll requestFileTestDataWithParam:nil];
}

- (void)testDBBtnAction:(UIButton *)sender {

}

- (void)testJsonBtnAction:(UIButton *)sender {
    
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
    cell.textLabel.text = joke.author;
    cell.detailTextLabel.text = joke.content;
    return cell;
}

#pragma mark - bll delegate
- (void)respondsFaildWithErrorCode:(NSString *)errorCode {

}

- (void)respondsGetTestData:(NSArray *)array {
    self.dataSource = array;
    [self.tableView reloadData];
}

- (void)respondsPostTestData:(NSArray *)array {
    
}

- (void)respondsFileTestData:(NSArray *)array {
    
}

@end
