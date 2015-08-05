//
//  SGKAnimationViewController.m
//  DemoStruts
//
//  Created by buding on 15/8/5.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKAnimationViewController.h"

@interface SGKAnimationViewController ()

@property (strong, nonatomic) UIView *view1;

@end

static int kUIViewAnimationOptionTransitions[] = {
    UIViewAnimationOptionTransitionFlipFromLeft,
    UIViewAnimationOptionTransitionFlipFromRight,
    UIViewAnimationOptionTransitionCurlUp,
    UIViewAnimationOptionTransitionCurlDown,
    UIViewAnimationOptionTransitionCrossDissolve,
    UIViewAnimationOptionTransitionFlipFromTop,
    UIViewAnimationOptionTransitionFlipFromBottom
};

@implementation SGKAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"动画";
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 7; i++) {
        [items addObject:[NSString stringWithFormat:@"动画%d", i]];
    }
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:items];
    seg.frame = CGRectMake(0, 70, self.view.frame.size.width, 60);
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 150, 300, 300)];

    [self.view addSubview:view1];
    self.view1 = view1;
    
}

- (void)segAction:(UISegmentedControl *)sender {

    [UIView transitionWithView:self.view1 duration:1.0f options:kUIViewAnimationOptionTransitions[sender.selectedSegmentIndex] animations:nil completion:nil];
}

@end
