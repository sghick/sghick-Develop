//
//  SMViewControllerA.m
//  Demo-AnimatePushViewController
//
//  Created by 丁治文 on 15/7/7.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMViewControllerA.h"

@interface SMViewControllerA ()

@end

@implementation SMViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"我是A";
    
}

- (void)viewWillAppear:(BOOL)animated {
    UIViewController *vc = self.presentingViewController;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:vc.view cache:YES];
    [UIView commitAnimations];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
