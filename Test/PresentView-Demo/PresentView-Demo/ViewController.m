//
//  ViewController.m
//  PresentView-Demo
//
//  Created by 丁治文 on 15/10/13.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "TestPresentView.h"

@interface ViewController ()<
    PresentViewDelegate >

@property (strong, nonatomic) TestPresentView *tPresentView;

@property (assign, nonatomic) CGFloat contentHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    showBtn.frame = CGRectMake(20, 20, 40, 40);
    [showBtn addTarget:self action:@selector(showBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    TestPresentView *tPresentView = [[TestPresentView alloc] initWithFrame:self.view.bounds];
    tPresentView.delegate = self;
    [tPresentView show:NO];
    [self.view addSubview:tPresentView];
    self.tPresentView = tPresentView;
    
    self.contentHeight = 100;
}

- (void)showBtnAction:(UIButton *)sender {
    self.contentHeight += 10;
    [self.tPresentView show:YES withContentHeight:self.contentHeight];
}

#pragma mark - PresentViewDelegate
- (BOOL)presentView:(PresentView *)view shouldCloseWhenTouchedAtContentView:(BOOL)atContentView {
    if (!atContentView && [view isKindOfClass:[TestPresentView class]]) {
        [((TestPresentView *)view) show:NO withContentHeight:self.contentHeight];
    }
    return NO;
}

@end
