//
//  ViewController.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SMAttributies.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;
@property (strong, nonatomic) UIView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    self.view1 = view1;
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor colorWithRed:122/255.0 green:222/255.0 blue:20/255.0 alpha:0.5];
    self.view2 = view2;
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:220/255.0 alpha:0.5];
    self.view3 = view3;
    
    [self.view addSubview:self.view1 attributePathKey:@"sample.frame2_1"];
    [self.view addSubview:self.view2 attributePathKey:@"sample.frame2_2"];
    [self.view addSubview:self.view3 attributePathKey:@"sample.frame2_3"];
    
    [self.view showNetLineWithRowAndColoum:CGPointMake(10, 16) lineColor:[UIColor redColor] showNumber:YES alpha:0];
}

@end
