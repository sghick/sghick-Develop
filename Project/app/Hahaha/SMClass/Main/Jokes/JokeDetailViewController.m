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
#import <CoreMotion/CoreMotion.h>
#import "JokeView.h"

@interface JokeDetailViewController ()

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) CMMotionManager *motion;
@property (strong, nonatomic) JokeView *jokeView;

@end

@implementation JokeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [self.view addSubview:self.jokeView attributePathKey:@"JokeDetailViewController.jokeView"];
    self.jokeView.joke = self.joke;
    
    // 开启重力感应
    BOOL openMotionSwitch = [SMUserDefaults boolForKey:kOpenMotionSwitch];
    gravityItem.title = (openMotionSwitch?@"关闭":@"开启");
    [self validateGravityStart:openMotionSwitch];
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
    [SMUserDefaults setBool:start forKey:kOpenMotionSwitch];
    if (start) {
        [self startMotionInQueue];
    } else {
        [self stopMotion];
    }
}

#pragma mark - gravity
- (void)startMotionInQueue {
    if (!self.motion.isAccelerometerActive && self.motion.isAccelerometerAvailable) {
        [self.motion startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
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

#pragma mark - setter/getter
- (JokeBll *)bll {
    if (_bll == nil) {
        JokeBll *bll = [[JokeBll alloc] init];
        bll.delegate = self;
        _bll = bll;
    }
    return _bll;
}

- (JokeView *)jokeView {
    if (_jokeView == nil) {
        JokeView *jokeView = [[JokeView alloc] init];
        _jokeView = jokeView;
    }
    return _jokeView;
}

- (void)setJoke:(SMJoke *)joke {
    if (_joke != joke) {
        _joke = joke;
        self.jokeView.joke = joke;
        self.title = self.joke.title;
        [self.bll makeJokeReadWithId:self.joke.xhid];
    }
}

@end
