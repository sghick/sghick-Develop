//
//  SMViewControllerB.m
//  Demo-AnimatePushViewController
//
//  Created by 丁治文 on 15/7/7.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMViewControllerB.h"
#import "ScanPushView.h"

@interface SMViewControllerB ()

@end

@implementation SMViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"我是B";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([self.pushViewProxy respondsToSelector:@selector(backToPresentingViewControllerWithTag:)]) {
        [self.pushViewProxy backToPresentingViewControllerWithTag:TAG_HELP];
    }
}

@end
