//
//  JokeDao.h
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMDAO.h"

@interface JokeDao : SMDAO

- (int)insertJokes:(NSArray *)jokes;
- (int)deleteJokes;
- (int)deleteJokesWithUid:(NSString *)uid;
- (int)updateJokes:(NSArray *)jokes;
- (NSArray *)searchJokes;
- (NSArray *)searchJokesWithUserId:(NSString *)uid;

@end
