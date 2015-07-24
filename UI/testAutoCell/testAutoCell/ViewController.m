//
//  ViewController.m
//  testAutoCell
//
//  Created by buding on 15/7/22.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "ViewController.h"
#import "AutoRect.h"
#import "TaTableViewCell.h"
#import "TbTableViewCell.h"

static NSString *identifiera = @"identifiera";
static NSString *identifierb = @"identifierb";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource1;
@property (strong, nonatomic) NSMutableArray *dataSource2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[TaTableViewCell class] forCellReuseIdentifier:identifiera];
    [tableView registerClass:[TbTableViewCell class] forCellReuseIdentifier:identifierb];
    
}

- (NSArray *)dataSource1 {
    if (!_dataSource1) {
        _dataSource1 = @[
                         @"AAAA",
                         @"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
                         @"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
                         ];
    }
    return _dataSource1;
}

- (NSArray *)dataSource2 {
    if (!_dataSource2) {
        _dataSource2 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 5; i++) {
            TbModel *model = [[TbModel alloc] init];
            model.name = [NSString stringWithFormat:@"BBBBBBBBBBBBBBBBBBBBBBBBBBBBB==%zi==", i];
            model.profile = [NSString stringWithFormat:@"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC==%zi==CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC", i];
            model.imageUrl = [NSString stringWithFormat:@"%c", 97 + i];
            [_dataSource2 addObject:model];
        }
    }
    return _dataSource2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource1.count + self.dataSource2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiera];
    if (indexPath.row < self.dataSource1.count) {
        TaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiera];
        cell.title = self.dataSource1[indexPath.row];
        return cell;
    } else if (indexPath.row < self.dataSource1.count + self.dataSource2.count) {
        TbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierb];
        cell.model = self.dataSource2[indexPath.row - self.dataSource1.count];
        return cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSource1.count) {
        return TaTableViewCell.ar_autoRect.size.height;
    } else if (indexPath.row < self.dataSource1.count + self.dataSource2.count) {
        return TbTableViewCell.ar_autoRect.size.height;
    }
    return 0;
}

@end
