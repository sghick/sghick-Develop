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
        SMDBManager *dbm = [[SMDBManager alloc] initWithDBName:@"testA.db"];
        [dbm createAndAlterTable:@"SGKUser" modelClass:[SGKUser class] primaryKeys:@[@"uid"]];
        self.dbm = dbm;
    }
    return self;
}

- (int)insertUsers:(NSArray *)users {
    int count = [self.dbm insertOrReplaceTable:@"SGKUser" models:users];
    return count;
}

- (int)deleteUsers {
    int count = [self.dbm deleteTable:@"SGKUser"];
    return count;
}

- (int)deleteUsersWithUid:(NSInteger)uid {
    int count = [self.dbm deleteTableWithSql:sql_delete_user_with_uid, uid];
    return count;
}

- (int)updateUsers:(NSArray *)users {
    int count = [self.dbm updateTable:@"SGKUser" models:users primaryKeys:@[@"uid"]];
    return count;
}

- (NSArray *)searchUsers {
    NSArray *rtns = [self.dbm searchTable:@"SGKUser" modelClass:[SGKUser class]];
    return rtns;
}

- (NSArray *)searchUsersWithUserId:(NSInteger)uid {
    NSArray *rtns = [self.dbm searchTableWithSqlFillModelClass:[SGKUser class] sql:sql_search_user_with_uid, [NSNumber numberWithInteger:uid], nil];
    return rtns;
}

@end
