//
//  JokeDao.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeDao.h"
#import "SMDBHelper.h"
#import "SqlHeader.h"
#import "SMJoke.h"

@interface JokeDao ()

@property (strong, nonatomic) SMDBHelper *dbHelper;

@end

@implementation JokeDao

- (instancetype)init {
    self = [super init];
    if (self) {
        SMDBHelper *dbHelper = [[SMDBHelper alloc] initWithDBName:@"jokes.db"];
        // 有多少个表需要自动更新的都要写上(最好每个版本只做一次)
        [dbHelper createAndAlterTable:@"tb_joke" modelClass:[SMJoke class] primaryKeys:@[@"xhid"]];
        self.dbHelper = dbHelper;
    }
    return self;
}

- (int)insertJokes:(NSArray *)jokes {
    int count = [self.dbHelper insertOrReplaceTable:@"tb_joke" models:jokes];
    return count;
}

- (int)deleteJokes {
    int count = [self.dbHelper deleteTable:@"tb_joke"];
    return count;
}

- (int)deleteJokesWithId:(NSString *)xhid {
    int count = [self.dbHelper deleteTableWithSql:sql_delete_jokes_with_id, xhid];
    return count;
}

- (int)updateJokes:(NSArray *)jokes {
    int count = [self.dbHelper updateTable:@"tb_joke" models:jokes primaryKeys:@[@"xhid"]];
    return count;
}

- (int)updateJoke:(SMJoke *)joke {
    int count = [self.dbHelper updateTable:@"tb_joke" models:@[joke] primaryKeys:@[@"xhid"]];
    return count;
}

- (NSArray *)searchJokes {
    NSArray *rtns = [self.dbHelper searchTableWithSqlFillModelClass:[SMJoke class] sql:sql_search_jokes, nil];
    return rtns;
}

- (NSArray *)searchJokesIsRead:(BOOL)isRead {
    NSArray *rtns = [self.dbHelper searchTableWithSqlFillModelClass:[SMJoke class] sql:sql_search_jokes_isRead, SMToString(@"%d", isRead), nil];
    return rtns;
}

- (NSArray *)searchJokesWithId:(NSString *)xhid {
    NSArray *rtns = [self.dbHelper searchTableWithSqlFillModelClass:[SMJoke class] sql:sql_search_jokes_with_id, xhid, nil];
    return rtns;
}

- (NSString *)searchJokesMaxid {
    NSArray *rtn = [self.dbHelper searchTableWithSqlFillModelClass:nil sql:sql_search_jokes_max_id, nil];
    NSDictionary *dict = [rtn firstObject];
    return dict[@"xhid"];
}

- (NSString *)searchJokesMinid {
    NSArray *rtn = [self.dbHelper searchTableWithSqlFillModelClass:nil sql:sql_search_jokes_min_id, nil];
    NSDictionary *dict = [rtn firstObject];
    return dict[@"xhid"];
}

@end
