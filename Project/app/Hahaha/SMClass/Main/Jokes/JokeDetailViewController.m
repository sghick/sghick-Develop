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

@interface JokeDetailViewController ()

@property (strong, nonatomic) JokeBll *bll;

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *imageView;

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
    
    
    // UI
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareItemAction:)];
    [self.navigationItem setRightBarButtonItem:shareItem];
    
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:15*SMWidthScale];
    contentLabel.text = self.joke.content;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.preferredMaxLayoutWidth = SMScreenWidth - 20*SMWidthScale;
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
    
    [self updateViewConstraints];
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

- (void)shareItemAction:(UIBarButtonItem *)sender {
    SMLog(@"share is clicked");
}

@end
