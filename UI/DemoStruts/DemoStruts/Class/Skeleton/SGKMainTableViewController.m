
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

@interface SGKMainTableViewController ()

@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) NSMutableArray * sectionState;

@end

@implementation SGKMainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSDictionary * jsonDict = [SGKJsonManager dictionaryWithFileName:@"example_categories"];
        NSArray * arr = [SGKCategoryModel arrayWithDictionary:jsonDict classNamesMapper:@{@"SGKCategoryModel": @"categories", @"SGKExampleModel": @"examples"}];
        _dataSource = arr;
        
        NSMutableArray * mSectionState = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < arr.count; i++) {
            SGKSectionStateModel * sectionState = [[SGKSectionStateModel alloc] init];
            [mSectionState addObject:sectionState];
        }
        _sectionState = mSectionState;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Demo索引";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SGKCategoryModel * cate = [_dataSource objectAtIndex:section];
    SGKSectionStateModel * sectionState = [_sectionState objectAtIndex:section];
    if (!sectionState.isOpen) {
        return 0;
    }
    return cate.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    SGKCategoryModel * cate = [_dataSource objectAtIndex:indexPath.section];
    SGKExampleModel * example = [[cate examples] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = example.title;
    cell.detailTextLabel.text = example.className;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SGKCategoryModel * cate = [_dataSource objectAtIndex:section];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTag:section];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:cate.title forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SGKCategoryModel * cate = [_dataSource objectAtIndex:indexPath.section];
    SGKExampleModel * example = [[cate examples] objectAtIndex:indexPath.row];
    Class controllerClass = NSClassFromString(example.className);
    UIViewController * subVC = [[controllerClass alloc] init];
    [subVC.navigationItem setTitle:example.title];
    [self.navigationController pushViewController:subVC animated:YES];
}

#pragma mark - action
- (void)headerAction:(UIButton *)btn{
    NSInteger section = btn.tag;
    [self showCellsForSction:section animations:YES];
    [self.tableView reloadData];
}

#pragma mark - operation
- (void)showCellsForSction:(NSInteger)section animations:(BOOL)animations{
    SGKSectionStateModel * sectionState = [_sectionState objectAtIndex:section];
    sectionState.isOpen = !sectionState.isOpen;
}

@end
