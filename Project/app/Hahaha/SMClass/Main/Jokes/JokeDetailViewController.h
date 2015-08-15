//
//  JokeDetailViewController.h
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMViewController.h"

@class JokeDetailViewController;
@protocol JokeDetailViewControllerDelegate <NSObject>

- (void)jokeDetailViewController:(JokeDetailViewController *)viewController changeToLastWithIndexPath:(NSIndexPath *)indexPath;
- (void)jokeDetailViewController:(JokeDetailViewController *)viewController changeToNextWithIndexPath:(NSIndexPath *)indexPath;

@end

@class SMJoke;
@interface JokeDetailViewController : SMViewController

@property (strong, nonatomic) SMJoke *joke;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (assign, nonatomic) id <JokeDetailViewControllerDelegate> delegate;

@end
