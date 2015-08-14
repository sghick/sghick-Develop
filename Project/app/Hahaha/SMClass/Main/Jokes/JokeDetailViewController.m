//
//  JokeDetailViewController.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeDetailViewController.h"
#import "SMJoke.h"

@interface JokeDetailViewController ()

@end

@implementation JokeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, 10, SMScreenWidth - 10, SMScreenHeight - 10);
    [self.view addSubview:textView];
    
    if (self.joke) {
        textView.text = self.joke.content;
    }
}


@end
