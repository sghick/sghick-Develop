//
//  ViewController.m
//  testAutoCell
//
//  Created by buding on 15/7/22.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewCell+AutoSize.h"
#import "TaTableViewCell.h"
#import "TbTableViewCell.h"

static NSString *identifiera = @"identifiera";
static NSString *identifierb = @"identifierb";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource1;
@property (strong, nonatomic) NSMutableArray *dataSource2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[TaTableViewCell class] forCellReuseIdentifier:identifiera];
    [tableView registerClass:[TbTableViewCell class] forCellReuseIdentifier:identifierb];
    
    NSArray *arr = @[@1,@2,@3,@4,@8,@4,@3];
    NSArray *arr2 = [arr sortedArrayUsingSelector:@selector(compare:)];
    
}

- (NSArray *)dataSource1 {
    if (!_dataSource1) {
        _dataSource1 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 1; i++) {
            NSString *name = @"A->name";
            int countN = arc4random()%20 + 1;
            for (int j = 0; j < countN; j++) {
                name = [name stringByAppendingFormat:@"%zi ", j];
            }
            [_dataSource1 addObject:name];
        }
    }
    return _dataSource1;
}

- (NSArray *)dataSource2 {
    if (!_dataSource2) {
        _dataSource2 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 10; i++) {
            TbModel *model = [[TbModel alloc] init];
            NSString *name = @"B->name";
            int countN = arc4random()%100 + 1;
            for (int j = 0; j < countN; j++) {
                name = [name stringByAppendingFormat:@"%zi ", j];
            }
            
            NSString *profile = @"B->profile";
            int countP = arc4random()%100 + 20;
            for (int j = 0; j < countP; j++) {
                if (j == 10) {
                    profile = [profile stringByAppendingString:@"Mark"];
                }
                else {
                    profile = [profile stringByAppendingFormat:@"%zi ", j];
                }
            }
            
            model.name = name;
            model.profile = profile;
            model.imageUrl = [NSString stringWithFormat:@"%c", 97 + i%26];
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
        // 在这里要注册
        [TaTableViewCell ar_setNeedsLayoutCell:cell indexPath:indexPath];
        cell.title = self.dataSource1[indexPath.row];
        return cell;
    } else if (indexPath.row < self.dataSource1.count + self.dataSource2.count) {
        TbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierb];
        // 在这里要注册
        [TbTableViewCell ar_setNeedsLayoutCell:cell indexPath:indexPath];
        cell.model = self.dataSource2[indexPath.row - self.dataSource1.count];
        return cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSource1.count) {
        // 在这里取出
        return [TaTableViewCell ar_autoHeightForRowIndexPath:indexPath];
    } else if (indexPath.row < self.dataSource1.count + self.dataSource2.count) {
        // 在这里取出
        return [TbTableViewCell ar_autoHeightForRowIndexPath:indexPath];
    }
    return 0;
}

@end
