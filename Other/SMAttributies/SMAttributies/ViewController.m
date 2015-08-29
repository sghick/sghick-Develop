//
//  ViewController.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SMAttributies.h"
#import "PureLayout.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;
@property (strong, nonatomic) UIView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"测试";
    
    [self.view addSubview:self.view1 attributePathKey:@"sample.frame3"];
    [self.view1 addSubview:self.view2 attributePathKey:@"sample.frame3_1"];
    [self.view2 addSubview:self.view3 attributePathKey:@"sample.frame3_2"];
    
//    [self.view addSubview:self.view1];
//    CGSize size = CGSizeMake(CGRectGetWidth(self.view.frame)/10.0, CGRectGetHeight(self.view.frame)/16.0);
    
//    [self.view1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view1.superview withOffset:1*size.width];
//    [self.view1 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view1.superview withOffset:-7*size.width];
//    [self.view1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view1.superview withOffset:6*size.width];
//    [self.view1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view1.superview withOffset:-7*size.width];
    
//    [self.view1 setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSDictionary *views = NSDictionaryOfVariableBindings(_view1);
//    NSMutableDictionary *metrics = [NSMutableDictionary dictionary];
//    [metrics setObject:[NSNumber numberWithDouble:1*size.width] forKey:@"left"];
//    [metrics setObject:[NSNumber numberWithDouble:7*size.width] forKey:@"right"];
//    [metrics setObject:[NSNumber numberWithDouble:6*size.width] forKey:@"top"];
//    [metrics setObject:[NSNumber numberWithDouble:7*size.width] forKey:@"bottom"];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[_view1]-right-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:metrics views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_view1]-bottom-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:metrics views:views]];
    
//    [self.view1 addConstraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view1.superview attribute:NSLayoutAttributeCenterX multiplier:(1+2/2)/(10/2.0) constant:0];
//    [self.view1 addConstraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view1.superview attribute:NSLayoutAttributeCenterY multiplier:(6+4/2)/(16/2.0) constant:0];
//    [self.view1 autoSetDimensionsToSize:CGSizeMake(2*size.width, 4*size.height)];
    
    
    
    [self.view showNetLineWithRowAndColoum:CGPointMake(10, 16) lineColor:[UIColor redColor] netType:35 alpha:0];
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [[UIView alloc] init];
        _view1.backgroundColor = [UIColor blueColor];
    }
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] init];
        _view2.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [[UIView alloc] init];
        _view3.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:220/255.0 alpha:0.5];
    }
    return _view3;
}

@end
