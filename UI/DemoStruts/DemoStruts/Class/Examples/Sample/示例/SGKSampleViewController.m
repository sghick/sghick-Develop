//
//  SGKSampleViewController.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/2.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKSampleViewController.h"
#import "NSString+MD5Addition.h"

@interface SGKSampleViewController ()

@end

@implementation SGKSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString * md5Pre = @"1234";
    NSString * md5After = [md5Pre stringFromMD5];
    NSLog(@"%@的md5:%@", md5Pre, [md5After uppercaseString]);
}


@end
