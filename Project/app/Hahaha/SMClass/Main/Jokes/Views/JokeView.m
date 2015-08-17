//
//  JokeView.m
//  Hahaha
//
//  Created by buding on 15/8/17.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeView.h"
#import "UIImageView+WebCache.h"
#import "SMJoke.h"

@interface JokeView ()

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation JokeView

- (instancetype)init {
    self = [super init];
    if (self) {
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:15*SMWidthScale];
        contentLabel.numberOfLines = 0;
        contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_contentLabel, _imageView);
    [UIView setTranslatesAutoresizingMaskIntoConstraintsWithViews:views flag:NO];
    NSDictionary *metrics = @{
                              @"margin":SMToString(@"%f", 20*SMWidthScale),
                              @"top":SMToString(@"%f", 64.0f)
                              };
    // 横向1
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_contentLabel]-margin-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 横向2
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    // 纵向1
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_contentLabel][_imageView]"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:metrics
                                                                        views:views]];
}

#pragma mark - setter/getter
- (void)setJoke:(SMJoke *)joke {
    if (_joke != joke) {
        _joke = joke;
        self.contentLabel.text = joke.content;
        if (joke.picUrl) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.joke.picUrl]];
        }
    }
}

@end
