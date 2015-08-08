//
//  ViewController.m
//  Demo-SMFrameWork
//
//  Created by buding on 15/8/3.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "ViewController.h"
#import "SampleBll.h"

@interface ViewController () <
SampleBllDelegate
>

@property (strong, nonatomic) SampleBll *bll;

@property (strong, nonatomic) SMButton *testGetBtn;
@property (strong, nonatomic) SMButton *testPostBtn;
@property (strong, nonatomic) SMButton *testFileBtn;
@property (strong, nonatomic) SMButton *testDBBtn;
@property (strong, nonatomic) SMButton *testJsonBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SampleBll *bll = [[SampleBll alloc] init];
    bll.delegate = self;
    self.bll = bll;
    
    SMButton *testGetBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testGetBtn addTarget:self action:@selector(testGetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.testGetBtn = testGetBtn;
    
    SMButton *testPostBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testPostBtn addTarget:self action:@selector(testPostBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.testPostBtn = testPostBtn;
    
    SMButton *testFileBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testFileBtn addTarget:self action:@selector(testFileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.testFileBtn = testFileBtn;
    
    SMButton *testDBBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testDBBtn addTarget:self action:@selector(testDBBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.testDBBtn = testDBBtn;
    
    SMButton *testJsonBtn = [SMButton buttonWithType:UIButtonTypeSystem];
    [testJsonBtn addTarget:self action:@selector(testJsonBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.testJsonBtn = testJsonBtn;
}

#pragma mark - action
- (void)testGetBtnAction:(UIButton *)sender {
    
}

- (void)testPostBtnAction:(UIButton *)sender {
    
}

- (void)testFileBtnAction:(UIButton *)sender {
    
}

- (void)testDBBtnAction:(UIButton *)sender {
    
}

- (void)testJsonBtnAction:(UIButton *)sender {
    
}

#pragma mark - bll delegate
- (void)respondsFaildWithErrorCode:(NSString *)errorCode {
    
}

- (void)respondsGetTestData:(NSArray *)array {
    
}

- (void)respondsPostTestData:(NSArray *)array {
    
}

- (void)respondsFileTestData:(NSArray *)array {
    
}

@end
