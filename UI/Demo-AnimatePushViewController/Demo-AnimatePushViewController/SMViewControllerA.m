//
//  SMViewControllerA.m
//  Demo-AnimatePushViewController
//
//  Created by 丁治文 on 15/7/7.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMViewControllerA.h"
#import "ScanPushView.h"

@interface SMViewControllerA ()

@end

@implementation SMViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"我是A";
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.pushViewProxy respondsToSelector:@selector(backToPresentingViewControllerWithTag:)]) {
        [self.pushViewProxy backToPresentingViewControllerWithTag:TAG_VIDEO];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
