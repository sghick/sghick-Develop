//
//  SGKCollectionViewController.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/12.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKCollectionViewController.h"
#import "SGKCollectionViewCell.h"

#define identifier @"collectionCell"

@interface SGKCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SGKCollectionViewController{
    UICollectionView * _collectionView;
    NSArray * _dataSource;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSMutableArray * data = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 50; i++) {
            [data addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _dataSource = data;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setAutoresizesSubviews:NO];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 300, 400) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[SGKCollectionViewCell class]forCellWithReuseIdentifier:identifier];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SGKCollectionViewCell * cell = (SGKCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setCellWithModel:[_dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {5,10,15,5};
    return top;
}

//设置顶部的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {20,20};
    return size;
}
//设置元素大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(120,120);
}

@end
