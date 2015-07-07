//
//  ViewController.m
//  Demo-MarkView
//
//  Created by 丁治文 on 15/7/1.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "ViewController.h"
#import "WPMarkView.h"

@interface ViewController ()<WPMarkViewDelegate>

@property (strong, nonatomic) WPMarkView *markView1;
@property (strong, nonatomic) WPMarkView *markView2;
@property (strong, nonatomic) WPMarkView *markView3;
@property (strong, nonatomic) WPMarkView *markView4;

@property (strong, nonatomic) NSArray *markViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISegmentedControl * seg = [[UISegmentedControl alloc] initWithItems:@[@"markView1", @"markView2", @"markView3", @"markView4"]];
    seg.frame = CGRectMake(10, 20, self.view.frame.size.width - 20, 30);
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    UIImage *image = [UIImage imageNamed:@"star"];
    UIImage *backImage = [UIImage imageNamed:@"star_back"];
    CGFloat width = self.view.frame.size.width;
    
    WPMarkView *markView1 = [[WPMarkView alloc] initWithFrame:CGRectMake(0, 140, width, width)];
    [markView1 setImage:image backImage:backImage numberOfMarks:3];
    markView1.markValue = 2.0;
    markView1.isSelect = YES;
    markView1.delegate = self;
    [markView1 setOffsets:@[@10, @30, @5] space:0];
    [self.view addSubview:markView1];
    
    WPMarkView *markView2 = [[WPMarkView alloc] initWithFrame:CGRectMake(0, 140, width, width)];
    [markView2 setImage:image backImage:backImage numberOfMarks:3];
    markView2.markValue = 2.0;
    markView2.isSelect = YES;
    markView2.delegate = self;
    markView2.isCustomSeat = YES;
    markView2.customFrames = @[
                               WPStringRect(10, 10, 40, 40),
                               WPStringRect(60, 50, 40, 40),
                               WPStringRect(110, 150, 40, 40)
                               ];
    [self.view addSubview:markView2];
    
    WPMarkView *markView3 = [[WPMarkView alloc] initWithFrame:CGRectMake(0, 140, width, width)];
    [markView3 setImage:image backImage:backImage numberOfMarks:3];
    markView3.markValue = 2.0;
    markView3.isSelect = YES;
    markView3.delegate = self;
    markView3.imageBounds = CGRectMake(0, 0, 60, 60);
    markView3.markDirection = WPMarkDirectionVertical;
    [self.view addSubview:markView3];
    
    WPMarkView *markView4 = [[WPMarkView alloc] initWithFrame:CGRectMake(0, 140, width, width)];
    [markView4 setImage:image backImage:backImage numberOfMarks:3];
    markView4.markValue = 2.0;
    markView4.isSelect = YES;
    markView4.delegate = self;
    markView4.markDirection = WPMarkDirectionALL;
    [self.view addSubview:markView4];
    
    self.markViews = @[markView1, markView2, markView3, markView4];
    [self setViewsHidden:YES views:self.markViews];
}

#pragma mark - WPMarkViewDelegate
- (void)markView:(WPMarkView *)markView selectedScore:(CGFloat)score {
    NSInteger index = [self.markViews indexOfObject:markView];
    NSLog(@"markView%zi selected score is:%f", index, score);
}

#pragma mark - segAction
- (void)segAction:(UISegmentedControl *)sender {
    [self setViewsHidden:YES views:self.markViews];
    ((UIView *)self.markViews[sender.selectedSegmentIndex]).hidden = NO;
}

- (void)setViewsHidden:(BOOL)hidden views:(NSArray *)views {
    for (UIView * view in views) {
        view.hidden = hidden;
    }
}

@end
