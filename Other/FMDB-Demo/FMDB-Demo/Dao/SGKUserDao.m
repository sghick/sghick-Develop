//
//  SGKUserDao.m
//  FMDB-Demo
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SGKUserDao.h"
#import "SGKUser.h"
#import "SMDBHelper.h"
#import "DAOHeader.h"

@interface SGKUserDao ()

@property (strong, nonatomic) SMDBHelper *dbHelper;

@end

@implementation SGKUserDao

- (instancetype)init {
    self = [super init];
    if (self) {
        SMDBHelper *dbHelper = [[SMDBHelper alloc] initWithDBName:@"testA.db"];
        [dbHelper createAndAlterTable:@"SGKUser" modelClass:[SGKUser class] primaryKeys:@[@"uid"]];
        self.dbHelper = dbHelper;
    }
    return self;
}

- (int)insertUsers:(NSArray *)users {
    int count = [self.dbHelper insertOrReplaceTable:@"SGKUser" models:users];
    return count;
}

- (int)deleteUsers {
    int count = [self.dbHelper deleteTable:@"SGKUser"];
    return count;
}

- (int)deleteUsersWithUid:(NSInteger)uid {
    int count = [self.dbHelper deleteTableWithSql:sql_delete_user_with_uid params:@[[NSNumber numberWithBool:uid]]];
    return count;
}

- (int)updateUsers:(NSArray *)users {
    int count = [self.dbHelper updateTable:@"SGKUser" models:users primaryKeys:@[@"uid"]];
    return count;
}

- (NSArray *)searchUsers {
    NSArray *rtns = [self.dbHelper searchTable:@"SGKUser" modelClass:[SGKUser class]];
    return rtns;
}

- (NSArray *)searchUsersWithUserId:(NSInteger)uid {
    NSArray *rtns = [self.dbHelper searchTableWithSql:sql_search_user_with_uid params:@[[NSNumber numberWithBool:uid]] modelClass:[SGKUser class]];
    return rtns;
}

@end
