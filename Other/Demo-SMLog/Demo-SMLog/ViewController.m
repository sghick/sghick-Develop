//
//  ViewController.m
//  Demo-SMLog
//
//  Created by buding on 15/7/31.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "ViewController.h"
#import "SMLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMLog(kLogDebug);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
