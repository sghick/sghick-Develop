//
//  SMDBManager.h
//  FMDB-Demo
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class SMModel;
@interface SMDBManager : NSObject

- (instancetype)initWithDBName:(NSString *)DBName;

- (BOOL)existTable:(NSString *)tableName;
+ (BOOL)existTable:(NSString *)tableName inDataBase:(FMDatabase *)db;
- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass;

- (int)insertTable:(NSString *)tableName models:(NSArray *)models;
- (int)deleteTable:(NSString *)tableName;
- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass;

- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models;
- (int)deleteTableWithSql:(NSString *)sql;
- (int)updateTableWithSql:(NSString *)sql model:(SMModel *)model;
- (NSArray *)searchTableWithSql:(NSString *)sql modelClass:(id)modelClass;

@end
