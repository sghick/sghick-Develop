//
//  SMRunViewController.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMRunViewController.h"
#import "SMRunScene001.h"
#import "SMRunMap001.h"

@interface SMRunViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) SMBaseScene *scene;

@end

@implementation SMRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - SMBaseViewControllerProtocol
- (void)loadData {
    [super loadData];
}

- (void)loadUI {
    [super loadUI];
    // 小伙伴快跑
    SMRunScene001 *scene001 = [SMRunScene001 scene];
    [self.view addSubview:scene001];
    self.scene = scene001;
}

- (void)loadUIData {
    [super loadUIData];
}

- (void)loadUIFrame {
    [super loadUIFrame];
}


@end
