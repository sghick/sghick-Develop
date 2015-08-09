//
//  SGKUserDao.h
//  FMDB-Demo
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SGKBaseDao.h"
#import "SGKUser.h"

@interface SGKUserDao : SGKBaseDao

- (int)insertUsers:(NSArray *)users;
- (int)deleteUsers;
- (int)deleteUsersWithUid:(NSInteger)uid;
- (int)updateUsers:(NSArray *)users;
- (NSArray *)searchUsers;
- (NSArray *)searchUsersWithUserId:(NSInteger)uid;

@end
