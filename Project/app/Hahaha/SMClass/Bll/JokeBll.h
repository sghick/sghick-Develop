//
//  JokeBll.h
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMBll.h"

@protocol JokeBllDelegate <NSObject>

- (void)respondsFaildWithErrorCode:(NSString *)errorCode;

- (void)respondsJokeList:(NSArray *)array curPage:(int)curPage;

@end

@class SMModel;
@interface JokeBll : SMBll

- (void)requestJokeListWithCurPage:(int)curPage;
- (void)makeJokeReadWithId:(NSString *)xhid;
- (NSArray *)searchJokesFromDB;

@end
