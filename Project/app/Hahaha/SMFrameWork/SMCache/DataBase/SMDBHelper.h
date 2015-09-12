//
//  SMDBHelper.h
//  Hahaha
//
//  Created by 丁治文 on 15/9/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class FMDatabaseQueue;
@interface SMDBHelper : NSObject

@property (strong, readonly, nonatomic) FMDatabaseQueue *dbQueue;

- (instancetype)initWithDBPath:(NSString *)DBPath;
- (instancetype)initWithDBName:(NSString *)DBName;

#pragma mark - Object Methods ExcuteInQueue
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
- (int)insertIfNotExistPrimaryKeysTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)insertTableWithSql:(NSString *)sql params:(NSArray *)params;

- (int)deleteTable:(NSString *)tableName;
- (int)deleteTableWithSql:(NSString*)sql params:(NSArray *)params;

- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)updateTableWithSql:(NSString *)sql params:(NSArray *)params;

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass;
- (NSArray *)searchTableWithSql:(NSString *)sql params:(NSArray *)params modelClass:(id)modelClass;

#pragma mark - Static Methods
+ (NSString *)sqlFromTable:(NSString *)tableName inDB:(FMDatabase *)db;
+ (BOOL)existTable:(NSString *)tableName inDB:(FMDatabase *)db;
+ (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass inDB:(FMDatabase *)db;
+ (BOOL)dropTable:(NSString *)tableName inDB:(FMDatabase *)db;
+ (BOOL)renameTable:(NSString *)tableName newTableName:(NSString *)newTableName inDB:(FMDatabase *)db;
+ (BOOL)recreateTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db;
+ (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db;
+ (BOOL)alterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db;

/** 自动创建/更新(推荐每个版本只做一次) */
+ (BOOL)createAndAlterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db;

+ (int)insertTable:(NSString *)tableName anotherTable:(NSString *)anotherTable inDB:(FMDatabase *)db;
+ (int)insertTable:(NSString *)tableName models:(NSArray *)models inDB:(FMDatabase *)db;
+ (int)insertOrReplaceTable:(NSString *)tableName models:(NSArray *)models inDB:(FMDatabase *)db;
+ (int)insertIfNotExistPrimaryKeysTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db;
+ (int)insertTableWithSql:(NSString *)sql params:(NSArray *)params inDB:(FMDatabase *)db;

+ (int)deleteTable:(NSString *)tableName inDB:(FMDatabase *)db;
+ (int)deleteTableWithSql:(NSString*)sql params:(NSArray *)params inDB:(FMDatabase *)db;

+ (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db;
+ (int)updateTableWithSql:(NSString *)sql params:(NSArray *)params inDB:(FMDatabase *)db;

+ (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass inDB:(FMDatabase *)db;
+ (NSArray *)searchTableWithSql:(NSString *)sql params:(NSArray *)params modelClass:(id)modelClass inDB:(FMDatabase *)db;

@end

