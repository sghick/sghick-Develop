//
//  JokeDao.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeDao.h"
#import "SMDBManager.h"
#import "SMDBHelper.h"
#import "SqlHeader.h"
#import "SMJoke.h"
#import "SMResult.h"

@implementation JokeDao

- (instancetype)init {
    self = [super init];
    if (self) {
        SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
        // 有多少个表需要自动更新的都要写上(最好每个版本只做一次)
        [dbHelper createAndAlterTable:@"tb_joke" modelClass:[SMJoke class] primaryKeys:@[@"xhid"]];
        [dbHelper createAndAlterTable:@"tb_result" modelClass:[SMResult class] primaryKeys:@[@"date"]];
    }
    return self;
}

- (int)insertResult:(SMResult *)result {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    return [dbHelper insertOrReplaceTable:@"tb_result" models:@[result]];
}

- (NSString *)dbPath {
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"jokes.db"];
    return dbPath;
}

- (int)insertJokes:(NSArray *)jokes {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    int count = [dbHelper insertIfNotExistPrimaryKeysTable:@"tb_joke" models:jokes conditionKeys:@[@"xhid"]];
    return count;
}

- (int)deleteJokes {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    int count = [dbHelper deleteTable:@"tb_joke"];
    return count;
}

- (int)deleteJokesWithId:(NSString *)xhid {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    int count = [dbHelper deleteTableWithSql:sql_delete_jokes_with_id params:@[xhid]];
    return count;
}

- (int)updateJokes:(NSArray *)jokes {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    int count = [dbHelper updateTable:@"tb_joke" models:jokes conditionKeys:@[@"xhid"]];
    return count;
}

- (int)updateJoke:(SMJoke *)joke {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    int count = [dbHelper updateTable:@"tb_joke" models:@[joke] conditionKeys:@[@"xhid"]];
    return count;
}

- (NSArray *)searchJokes {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    NSArray *rtns = [dbHelper searchTable:@"tb_joke" modelClass:[SMJoke class]];
    return rtns;
}

- (NSArray *)searchJokesIsRead:(BOOL)isRead {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    NSArray *rtns = [dbHelper searchTableWithSql:sql_search_jokes_isRead params:@[[NSNumber numberWithBool:isRead]] modelClass:[SMJoke class]];
    return rtns;
}

- (NSArray *)searchJokesWithId:(NSString *)xhid {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    NSArray *rtns = [dbHelper searchTableWithSql:sql_search_jokes_with_id params:@[xhid] modelClass:[SMJoke class]];
    return rtns;
}

- (NSString *)searchJokesMaxid {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    NSArray *rtn = [dbHelper searchTableWithSql:sql_search_jokes_max_id params:nil modelClass:nil];
    NSDictionary *dict = [rtn firstObject];
    return dict[@"xhid"];
}

- (NSString *)searchJokesMinid {
    SMDBHelper *dbHelper = [SMDBManager dbHelperWithDBPath:[self dbPath]];
    NSArray *rtn = [dbHelper searchTableWithSql:sql_search_jokes_min_id params:nil modelClass:nil];
    NSDictionary *dict = [rtn firstObject];
    return dict[@"xhid"];
}

@end
