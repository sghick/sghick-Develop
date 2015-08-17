//
//  JokeDetailViewController.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeDetailViewController.h"
#import "JokeBll.h"
#import "SMJoke.h"
#import "UIImageView+WebCache.h"
#import <CoreMotion/CoreMotion.h>

@interface JokeDetailViewController ()

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) CMMotionManager *motion;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *imageView;

// 要等待完全载入了才能响应重力感应
@property (assign, nonatomic) BOOL gravity;

@end

@implementation JokeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JokeBll *bll = [[JokeBll alloc] init];
    self.bll = bll;
    
    self.title = self.joke.title;
    
    // 手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    // 重力感应
    CMMotionManager *motion = [[CMMotionManager alloc] init];
    motion.accelerometerUpdateInterval = 1/60.f;
    self.motion = motion;
    
    // UI
    UIBarButtonItem *gravityItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(gravityItemAction:)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareItemAction:)];
    [self.navigationItem setRightBarButtonItems:@[gravityItem, shareItem]];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:15*SMWidthScale];
    contentLabel.text = self.joke.content;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (self.joke.picUrl) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.joke.picUrl]];
    }
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    
    // Bussiness
    [self.bll makeJokeReadWithId:self.joke.xhid];
    // 开启重力感应
    [self validateGravityStart:YES];
    
    [self updateViewConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.gravity = YES;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_contentLabel, _imageView);
    [UIView setTranslatesAutoresizingMaskIntoConstraintsWithViews:views flag:NO];
    NSDictionary *metrics = @{
                              @"margin":SMToString(@"%f", 20*SMWidthScale),
                              @"top":SMToString(@"%f", 64.0f)
                              };
    // 横向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_contentLabel]-margin-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 横向2
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 纵向1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_contentLabel][_imageView]"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:metrics
                                                                        views:views]];
}

#pragma mark - action
- (BOOL)leftSwipeAction:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(jokeDetailViewController:changeToNextWithIndexPath:)]) {
       return [self.delegate jokeDetailViewController:self changeToNextWithIndexPath:self.indexPath];
    }
    return NO;
}

- (BOOL)rightSwipeAction:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(jokeDetailViewController:changeToLastWithIndexPath:)]) {
       return [self.delegate jokeDetailViewController:self changeToLastWithIndexPath:self.indexPath];
    }
    return NO;
}

- (void)shareItemAction:(UIBarButtonItem *)sender {
    SMLog(@"share is clicked");
}

- (void)gravityItemAction:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"关闭"]) {
        sender.title = @"开启";
        [self validateGravityStart:NO];
    } else {
        sender.title = @"关闭";
        [self validateGravityStart:YES];
    }
}

- (void)validateGravityStart:(BOOL)start {
    if (start) {
        [self startMotionInQueue];
    } else {
        [self stopMotion];
    }
}

#pragma mark - gravity
- (void)startMotionInQueue {
    if (!self.motion.isAccelerometerActive && self.motion.isAccelerometerAvailable) {
        [self.motion startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (self.gravity) {
                if (accelerometerData.acceleration.x < -0.5) {
                    // 左倾斜
                    self.gravity = ![self leftSwipeAction:nil];
                } else if (accelerometerData.acceleration.x > 0.5) {
                    // 右倾斜
                    self.gravity = ![self rightSwipeAction:nil];
                }
            }
        }];
    }
}

- (void)stopMotion {
    if (self.motion.isAccelerometerActive) {
        [self.motion stopAccelerometerUpdates];
    }
}

@end
