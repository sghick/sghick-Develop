//
//  SMDBManager.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class SMModel;
@interface SMDBManager : NSObject

@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) NSString *DBName;

- (instancetype)initWithDBPath:(NSString *)DBPath;
- (instancetype)initWithDBName:(NSString *)DBName;

- (BOOL)existTable:(NSString *)tableName;
+ (BOOL)existTable:(NSString *)tableName inDataBase:(FMDatabase *)db;
- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass;

- (int)insertTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;

- (int)deleteTable:(NSString *)tableName;
- (int)deleteTableWithSql:(NSString*)sql, ...;

- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys;
- (int)updateTableWithSql:(NSString *)sql model:(SMModel *)model;
- (int)updateTableWithSql:(NSString *)sql, ...;

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass;
- (NSArray *)searchTableWithSqlFillModelClass:(id)modelClass sql:(NSString *)sql, ...;
- (NSDictionary *)searchTableWithSql:(NSString *)sql, ...;

@end
