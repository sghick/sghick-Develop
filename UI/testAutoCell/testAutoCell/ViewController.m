//
//  ViewController.m
//  testAutoCell
//
//  Created by buding on 15/7/22.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "ViewController.h"
#import "SelfDefineCell.h"

static NSString *identifier = @"identifier";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = @[
                        @"AAAA",
                        @"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
                        @"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
                        ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[SelfDefineCell class] forCellReuseIdentifier:identifier];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelfDefineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.title = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SelfDefineCell.autoHeight;
}

@end
