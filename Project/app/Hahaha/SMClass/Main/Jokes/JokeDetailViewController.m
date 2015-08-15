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

@interface JokeDetailViewController ()

@property (strong, nonatomic) JokeBll *bll;

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
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, 10, SMScreenWidth - 10, SMScreenHeight - 10);
    textView.userInteractionEnabled = NO;
    [self.view addSubview:textView];
    
    JokeBll *bll = [[JokeBll alloc] init];
    self.bll = bll;
    
    self.title = self.joke.author;
    textView.text = self.joke.content;
    
    [self.bll makeJokeReadWithId:self.joke.xhid];
}

- (void)leftSwipeAction:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(jokeDetailViewController:changeToNextWithIndexPath:)]) {
        [self.delegate jokeDetailViewController:self changeToNextWithIndexPath:self.indexPath];
    }
}

- (void)rightSwipeAction:(UISwipeGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(jokeDetailViewController:changeToLastWithIndexPath:)]) {
        [self.delegate jokeDetailViewController:self changeToLastWithIndexPath:self.indexPath];
    }
}


@end
