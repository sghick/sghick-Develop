//
//  SampleDao.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SampleDao.h"
#import "SMDBManager.h"
#import "SqlHeader.h"
#import "SMJoke.h"

@interface SampleDao ()

@property (strong, nonatomic) SMDBManager *dbm;

@end

@implementation SampleDao

- (instancetype)init {
    self = [super init];
    if (self) {
        SMDBManager *dbm = [[SMDBManager alloc] initWithDBName:@"jokes.db"];
        self.dbm = dbm;
    }
    return self;
}

- (int)insertJokes:(NSArray *)jokes {
    int count = [self.dbm insertTable:@"tb_joke" models:jokes primaryKeys:@[@"uid"]];
    return count;
}

- (int)deleteJokes {
    int count = [self.dbm deleteTable:@"tb_joke"];
    return count;
}

- (int)deleteJokesWithUid:(NSString *)uid {
    int count = [self.dbm deleteTableWithSql:sql_delete_jokes_with_uid, uid];
    return count;
}

- (int)updateJokesReadWithUid:(NSString *)uid {
    int count = [self.dbm updateTableWithSql:sql_set_jokes_read_with_uid, uid];
    return count;
}

- (int)updateJokes:(NSArray *)jokes {
    int count = [self.dbm updateTable:@"tb_joke" models:jokes primaryKeys:@[@"uid"]];
    return count;
}

- (NSArray *)searchJokes {
    NSArray *rtns = [self.dbm searchTable:@"tb_joke" modelClass:[SMJoke class]];
    return rtns;
}

- (NSArray *)searchJokesWithUserId:(NSString *)uid {
    NSString *sql = SMToString(@"SELECT * FROME tb_joke WHERE uid=%@", uid);
    NSArray *rtns = [self.dbm searchTableWithSqlFillModelClass:[SMJoke class] sql:sql];
//    NSArray *rtns = [self.dbm searchTableWithSqlFillModelClass:[SMJoke class] sql:sql_search_jokes_with_uid, uid];
    return rtns;
}

@end
