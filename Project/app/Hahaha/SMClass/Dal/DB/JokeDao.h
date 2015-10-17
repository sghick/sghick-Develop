//
//  JokeDao.h
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMDAO.h"

@class SMJoke;
@class SMResult;
@interface JokeDao : SMDAO

- (int)insertJokes:(NSArray *)jokes;
- (int)deleteJokes;
- (int)deleteJokesWithId:(NSString *)xhid;
- (int)updateJokes:(NSArray *)jokes;
- (int)updateJoke:(SMJoke *)joke;
- (NSArray *)searchJokes;
- (NSArray *)searchJokesIsRead:(BOOL)isRead;
- (NSArray *)searchJokesWithId:(NSString *)xhid;
- (NSString *)searchJokesMaxid;
- (NSString *)searchJokesMinid;

- (int)insertResult:(SMResult *)result;

@end
