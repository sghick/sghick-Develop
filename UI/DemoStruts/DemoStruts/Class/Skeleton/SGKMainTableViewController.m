
//
//  SGKMainTableViewController.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/1.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKMainTableViewController.h"
#import "SGKJsonManager.h"
#import "SGKCategoryModel.h"
#import "SGKExampleModel.h"
#import "SGKSectionStateModel.h"

static NSString *identifier = @"cell";

@interface SGKMainTableViewController () <
UITableViewDataSource,
UITableViewDelegate >

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSArray *sections;

@end

@implementation SGKMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Demo索引";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self setExtraCellLineHidden];
    
    NSDictionary * jsonDict = [SGKJsonManager dictionaryWithFileName:@"example_categories"];
    NSArray * arr = [SGKCategoryModel arrayWithDictionary:jsonDict classNamesMapper:@{@"SGKCategoryModel": @"categories", @"SGKExampleModel": @"examples"}];
    self.dataSource = arr;
    
    NSMutableArray * sections = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < arr.count; i++) {
        SGKSectionStateModel * sectionState = [[SGKSectionStateModel alloc] init];
        [sections addObject:sectionState];
    }
    self.sections = sections;

}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SGKCategoryModel * cate = [_dataSource objectAtIndex:section];
    SGKSectionStateModel * sectionState = [self.sections objectAtIndex:section];
    if (!sectionState.isOpen) {
        return 0;
    }
    return cate.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    SGKCategoryModel * cate = [self.dataSource objectAtIndex:indexPath.section];
    SGKExampleModel * example = [[cate examples] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = example.title;
    cell.detailTextLabel.text = example.className;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SGKCategoryModel * cate = [self.dataSource objectAtIndex:section];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTag:section];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:cate.title forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SGKCategoryModel * cate = [self.dataSource objectAtIndex:indexPath.section];
    SGKExampleModel * example = [[cate examples] objectAtIndex:indexPath.row];
    NSLog(@"%@ didSelected", example.className);
    Class controllerClass = NSClassFromString(example.className);
    UIViewController * subVC = [[controllerClass alloc] init];
    [subVC.navigationItem setTitle:example.title];
    [self.navigationController pushViewController:subVC animated:YES];
}

#pragma mark - action
- (void)headerAction:(UIButton *)btn {
    NSInteger section = btn.tag;
    [self showCellsForSction:section animations:YES];
}

#pragma mark - operation
- (void)showCellsForSction:(NSInteger)section animations:(BOOL)animations {
    SGKSectionStateModel *sectionState = [self.sections objectAtIndex:section];
    sectionState.isOpen = !sectionState.isOpen;
    
    SGKCategoryModel * cate = [self.dataSource objectAtIndex:section];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < cate.examples.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPaths addObject:indexPath];
    }
    
    [self.tableView beginUpdates];
    if (sectionState.isOpen) {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    } else {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    }
    [self.tableView endUpdates];
}

- (void)setExtraCellLineHidden{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

@end
