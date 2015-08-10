//
//  SampleDao.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleDao : NSObject

- (int)insertJokes:(NSArray *)jokes;
- (int)deleteJokes;
- (int)deleteJokesWithUid:(NSString *)uid;
- (int)updateJokes:(NSArray *)jokes;
- (NSArray *)searchJokes;
- (NSArray *)searchJokesWithUserId:(NSString *)uid;

@end
