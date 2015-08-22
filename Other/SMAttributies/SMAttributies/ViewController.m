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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view1 attributePathKey:@"ViewController.frame1"];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor colorWithRed:122/255.0 green:222/255.0 blue:20/255.0 alpha:0.5];
    [view1 addSubview:view2 attributePathKey:@"ViewController.frame2"];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:220/255.0 alpha:0.5];
    [view2 addSubview:view3 attributePathKey:@"ViewController.frame3"];
}

@end
