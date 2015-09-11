//
//  SMDBManager.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class FMDatabase;
@interface SMDBManager : NSObject

@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) NSString *DBName;

- (instancetype)initWithDBPath:(NSString *)DBPath;
- (instancetype)initWithDBName:(NSString *)DBName;

+ (NSString *)sqlFromTable:(NSString *)tableName inDataBase:(FMDatabase *)db;
+ (BOOL)existTable:(NSString *)tableName inDataBase:(FMDatabase *)db;
+ (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass inDataBase:(FMDatabase *)db;
- (BOOL)existTable:(NSString *)tableName;
- (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass;
- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys;
- (BOOL)alterTable:(NSString *)tableName modelClass:(id)modelClass;
- (BOOL)createAndAlterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys;

- (int)insertTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)insertTable:(NSString *)tableName model:(NSObject *)model primaryKeys:(NSArray *)primaryKeys;
- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)insertTableWithSql:(NSString *)sql model:(NSObject *)model primaryKeys:(NSArray *)primaryKeys;

- (int)deleteTable:(NSString *)tableName;
- (int)deleteTableWithSql:(NSString*)sql, ...;

- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)updateTable:(NSString *)tableName model:(NSObject *)model primaryKeys:(NSArray *)primaryKeys;
- (int)updateTableWithSql:(NSString *)sql model:(NSObject *)model;
- (int)updateTableWithSql:(NSString *)sql, ...;

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass;
- (NSArray *)searchTableWithSqlFillModelClass:(id)modelClass sql:(NSString *)sql, ... NS_REQUIRES_NIL_TERMINATION;

@end
