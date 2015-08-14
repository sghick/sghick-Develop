//
//  SMDBManager.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMDBManager.h"
#import "FMDB.h"
#import <objc/runtime.h>
#import "SMModel.h"

#define dbTypeMapper @{                 \
@"T@\"NSString\"":@"TEXT",              \
@"T@\"NSMutableString\"":@"TEXT",       \
@"T@\"NSDictionary\"":@"BLOB",          \
@"T@\"NSMutableDictionary\"":@"BLOB",   \
@"T@\"NSMutableArray\"":@"BLOB",        \
@"T@\"NSArray\"":@"BLOB",               \
@"T@\"NSData\"":@"BLOB",                \
@"T@\"NSDate\"":@"DATE",                \
@"T@\"NSNumber\"":@"REAL",              \
@"T@\"NSValue\"":@"REAL",               \
@"Tq":@"Integer",                       \
@"Ti":@"Integer",                       \
@"Tf":@"FLOAT",                         \
@"Td":@"DOUBLE",                        \
@"TB":@"BOOLEAN",                       \
@"Tb":@"BOOLEAN",                       \
@"Other":@"BLOB"                        \
}

@implementation SMDBManager

- (instancetype)initWithDBPath:(NSString *)DBPath {
    self = [super init];
    if (self) {
        FMDatabase *db = [[FMDatabase alloc] initWithPath:DBPath];
        NSLog(@"dbPath:%@", DBPath);
        self.db = db;
    }
    return self;
}

- (instancetype)initWithDBName:(NSString *)DBName {
    NSString *dbName = DBName;
    if (![dbName hasSuffix:@".db"]) {
        dbName = [DBName stringByAppendingPathExtension:@"db"];
    }
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DBName];
    self = [self initWithDBPath:dbPath];
    return self;
}

+ (BOOL)existTable:(NSString *)tableName inDataBase:(FMDatabase *)db {
    BOOL isSet = [db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", db.lastErrorMessage);
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        [db close];
        return count;
    }
    [db close];
    return NO;
}

- (BOOL)existTable:(NSString *)tableName {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    BOOL rtn = [SMDBManager existTable:tableName inDataBase:self.db];
    [self.db close];
    return rtn;
}

- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    NSString *className = NSStringFromClass([modelClass class]);
    NSString *name = (tableName&&tableName.length ? tableName : className);
    NSMutableString *sqlQuery = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (", name];
    
    // 设置字段/主键
    id classM = objc_getClass([className UTF8String]);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(classM, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *attributeName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *attributeString = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSArray *attributes = [attributeString componentsSeparatedByString:@","];
        NSString *attributeType = [attributes firstObject];
        NSString *dbType = dbTypeMapper[attributeType];
        if (!dbType) {
            attributeType = @"Other";
            NSAssert1(YES, @"未知类型:%@, 请完善", attributeType);
        }

        if (i == outCount - 1) {
            [sqlQuery appendFormat:@"%@ %@);", attributeName, dbType];
            break;
        }
        // 主键
        if ([primaryKeys containsObject:attributeName]) {
            [sqlQuery appendFormat:@"%@ %@ primary key, ", attributeName, dbType];
        } else {
            [sqlQuery appendFormat:@"%@ %@, ", attributeName, dbType];
        }
    }
    BOOL isSuccess = [self.db executeUpdate:sqlQuery];
    NSAssert2(isSuccess, @"创建数据库失败! %@ %@", self.db.lastErrorMessage, sqlQuery);
    [self.db close];
    return isSuccess;
}

- (int)insertTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys {
    if (!models || !models.count) {
        return 0;
    }
    NSString *sql = [self sqlForInsertWithTableName:tableName model:[models firstObject]];
    int count = [self insertTableWithSql:sql models:models primaryKeys:primaryKeys];
    return count;
}

- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys {
    if (!sql || !sql.length) {
        return 0;
    }
    
    NSString *sql1 = [sql stringByReplacingOccurrencesOfString:@"(" withString:@" "];
    sql1 = [sql1 stringByReplacingOccurrencesOfString:@")" withString:@" "];
    NSArray *sqlComponents = [sql1 componentsSeparatedByString:@" "];
    NSString *tableName = nil;
    BOOL canBreak = NO;
    for (NSString *str in sqlComponents) {
        if (str.length && canBreak) {
            tableName = str;
            break;
        }
        if ([[str uppercaseString] rangeOfString:@"INTO"].length) {
            canBreak = YES;
        }
    }
    NSAssert(tableName, @"sql语句错误!");
    
    if (!models || !models.count) {
        return 0;
    }
    if (![self existTable:tableName]) {
        [self createTable:tableName modelClass:[[models firstObject] class] primaryKeys:primaryKeys];
    }
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[SMModel class]]) {
            NSString *sql = [self sqlForInsertWithTableName:tableName model:model];
            BOOL isSuccess = [self.db executeUpdate:sql withParameterDictionary:((SMModel *)model).dictionary];
            count += isSuccess;
        }
    }
    [self.db close];
    return count;
}

- (int)deleteTable:(NSString *)tableName {
    NSString *sql = [self sqlForDeleteWithTableName:tableName];
    int count = [self deleteTableWithSql:sql];
    return count;
}

- (int)deleteTableWithSql:(NSString*)sql, ... {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    BOOL isSuccess = [self.db executeUpdate:sql];
    [self.db close];
    return isSuccess;
}

- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys {
    if (!models || !models.count) {
        return 0;
    }
    NSString *sql = [self sqlForUpdateWithTableName:tableName model:[models firstObject] primaryKeys:primaryKeys];
    if (!models || !models.count) {
        return 0;
    }
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[SMModel class]]) {
            BOOL isSuccess = [self.db executeUpdate:sql withParameterDictionary:((SMModel *)model).dictionary];
            count += isSuccess;
        }
    }
    [self.db close];
    return count;
}

- (int)updateTableWithSql:(NSString *)sql model:(SMModel *)model {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    BOOL isSuccess = [self.db executeUpdate:sql withParameterDictionary:((SMModel *)model).dictionary];
    [self.db close];
    return isSuccess;
}

- (int)updateTableWithSql:(NSString *)sql, ... {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    BOOL isSuccess = [self.db executeUpdate:sql];
    [self.db close];
    return isSuccess;
}

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass {
    NSString *sql = [self sqlForSearchWithTableName:tableName];
    NSArray *rtns = [self searchTableWithSqlFillModelClass:modelClass sql:sql];
    return rtns;
}

#warning 用占位符或者参数名时会崩溃，未找到原因
- (NSArray *)searchTableWithSqlFillModelClass:(id)modelClass sql:(NSString *)sql, ... {
    if (!sql || !sql.length) {
        return 0;
    }
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    FMResultSet * set = [self.db executeQuery:sql];
    NSMutableArray * rtns = [NSMutableArray array];
    while ([set next]) {
        NSDictionary *dict = [set resultDictionary];
        Class mdClass = [modelClass class];
        NSObject *model = [[mdClass alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [rtns addObject:model];
    }
    [self.db close];
    return rtns;
}

- (NSDictionary *)searchTableWithSql:(NSString *)sql, ... {
    if (!sql || !sql.length) {
        return 0;
    }
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    FMResultSet * set = [self.db executeQuery:sql];
    [self.db close];
    return set.resultDictionary;
}

#pragma mark - ()
- (NSString *)sqlForInsertWithTableName:(NSString *)tableName model:(SMModel *)model {
    NSMutableString *properties = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    for (NSString *key in model.dictionary.allKeys) {
        [properties appendFormat:@"%@,", key];
        [values appendFormat:@":%@,", key];
    }
    [properties replaceCharactersInRange:NSMakeRange(properties.length - 1, 1) withString:@""];
    [values replaceCharactersInRange:NSMakeRange(values.length - 1, 1) withString:@""];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO %@ (%@) VALUES(%@)", tableName, properties, values];
    return sql;
}

- (NSString *)sqlForDeleteWithTableName:(NSString *)tableName {
    NSMutableString *sql = [NSMutableString stringWithFormat:@"DELETE FROM %@ ", tableName];
    return sql;
}

- (NSString *)sqlForUpdateWithTableName:(NSString *)tableName model:(SMModel *)model primaryKeys:(NSArray *)primaryKeys {
    NSMutableString *set = [NSMutableString string];
    for (NSString *key in model.dictionary.allKeys) {
        [set appendFormat:@"%@=:%@,", key, key];
    }
    [set replaceCharactersInRange:NSMakeRange(set.length - 1, 1) withString:@""];
    
    NSMutableString *condition = [NSMutableString string];
    for (NSString *key in primaryKeys) {
        [condition appendFormat:@"%@=:%@ and ", key, key];
    }
    [condition replaceCharactersInRange:NSMakeRange(condition.length - 5, 5) withString:@""];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE %@ set %@ WHERE %@", tableName, set, condition];
    return sql;
}

- (NSString *)sqlForSearchWithTableName:(NSString *)tableName {
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT * FROM %@ ", tableName];
    return sql;
}

@end
