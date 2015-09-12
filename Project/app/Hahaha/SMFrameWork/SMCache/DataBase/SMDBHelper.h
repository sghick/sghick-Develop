//
//  SMDBHelper.h
//  Hahaha
//
//  Created by 丁治文 on 15/9/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class FMDatabase;
@interface SMDBHelper : NSObject

@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) NSString *DBName;

- (instancetype)initWithDBPath:(NSString *)DBPath;
- (instancetype)initWithDBName:(NSString *)DBName;

- (NSString *)sqlFromTable:(NSString *)tableName;
- (BOOL)existTable:(NSString *)tableName;
- (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass;
- (BOOL)dropTable:(NSString *)tableName;
- (BOOL)renameTable:(NSString *)tableName newTableName:(NSString *)newTableName;
- (BOOL)recreateTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys;
- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys;
- (BOOL)alterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys;

- (BOOL)createAndAlterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys; /* 自动创建/更新(推荐每个版本只做一次) */

- (int)insertTable:(NSString *)tableName anotherTable:(NSString *)anotherTable;
- (int)insertTable:(NSString *)tableName models:(NSArray *)models;
- (int)insertOrReplaceTable:(NSString *)tableName models:(NSArray *)models;
- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models;

- (int)deleteTable:(NSString *)tableName;
- (int)deleteTableWithSql:(NSString*)sql, ...;

- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)updateTableWithSql:(NSString *)sql models:(NSArray *)models;
- (int)updateTableWithSql:(NSString *)sql, ...;

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass;
- (NSArray *)searchTableWithSqlFillModelClass:(id)modelClass sql:(NSString *)sql, ... NS_REQUIRES_NIL_TERMINATION;

@end

