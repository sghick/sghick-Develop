//
//  SGKUserDao.m
//  FMDB-Demo
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SGKUserDao.h"
#import "SGKUser.h"
#import "SMDBManager.h"
#import "DAOHeader.h"

@interface SGKUserDao ()

@property (strong, nonatomic) SMDBManager *dbm;

@end

@implementation SGKUserDao

- (instancetype)init {
    self = [super init];
    if (self) {
        SMDBManager *dbm = [[SMDBManager alloc] initWithDBName:@"test.db"];
        self.dbm = dbm;
    }
    return self;
}

- (int)insertUsers:(NSArray *)users {
    int count = [self.dbm insertTable:@"SGKUser" models:users];
//    int count = [self.dbm insertTableWithSql:sql_insert_user models:users];
    return count;
}

- (int)deleteUsers {
    int count = [self.dbm deleteTable:@"SGKUser"];
    return count;
}

- (int)deleteUsersWithUid:(NSString *)uid {
    NSString *sql = [NSString stringWithFormat:sql_delete_user_with_uid, uid];
    int count = [self.dbm deleteTableWithSql:sql];
    return count;
}

- (int)updateUsers:(NSArray *)users {
    int count = [self.dbm updateTable:@"SGKUser" models:users primaryKeys:@[@"uid"]];
//    int count = [self.dbm updateTableWithSql:sql_update_user model:[users firstObject]];
    return count;
}

- (NSArray *)searchUsers {
//    NSArray *rtns = [self.dbm searchTable:@"SGKUser" modelClass:[SGKUser class]];
    NSArray *rtns = [self.dbm searchTableWithSql:sql_search_user modelClass:[SGKUser class]];
    return rtns;
}

- (NSArray *)searchUsersWithUserId:(NSString *)uid {
    NSString *sql = [NSString stringWithFormat:sql_search_user_with_uid, uid];
    NSArray *rtns = [self.dbm searchTableWithSql:sql modelClass:[SGKUser class]];
    return rtns;
}

@end
