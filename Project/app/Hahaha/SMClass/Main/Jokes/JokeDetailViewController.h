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

- (BOOL)jokeDetailViewController:(JokeDetailViewController *)viewController changeToLastWithIndexPath:(NSIndexPath *)indexPath;
- (BOOL)jokeDetailViewController:(JokeDetailViewController *)viewController changeToNextWithIndexPath:(NSIndexPath *)indexPath;

@end

@class SMJoke;
@interface JokeDetailViewController : SMViewController

@property (strong, nonatomic) SMJoke *joke;
@property (strong, nonatomic) NSIndexPath *indexPath;
// 要等待完全载入了才能响应重力感应
@property (assign, nonatomic) BOOL gravity;

@property (assign, nonatomic) id <JokeDetailViewControllerDelegate> delegate;

@end
