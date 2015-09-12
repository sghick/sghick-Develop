//
//  SMDBHelper.m
//  Hahaha
//
//  Created by 丁治文 on 15/9/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMDBHelper.h"
#import "FMDB.h"
#import <objc/runtime.h>

#define dbTypeMapper @{                 \
@"T@\"NSString\"":@"TEXT",              \
@"T@\"NSMutableString\"":@"TEXT",       \
@"T@\"NSDictionary\"":@"TEXT",          \
@"T@\"NSMutableDictionary\"":@"TEXT",   \
@"T@\"NSMutableArray\"":@"TEXT",        \
@"T@\"NSArray\"":@"TEXT",               \
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
@"Other":@"TEXT"                        \
}

@implementation SMDBHelper

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

- (NSString *)sqlFromTable:(NSString *)tableName {
    NSString *rtn = nil;
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    FMResultSet *rs = [self.db executeQuery:@"select * from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        rtn = [rs stringForColumn:@"sql"];
        break;
    }
    [self.db close];
    return rtn;
}

- (BOOL)existTable:(NSString *)tableName {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    FMResultSet *rs = [self.db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        [self.db close];
        return count;
    }
    [self.db close];
    return NO;
}


- (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    FMResultSet *rs = [self.db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        [self.db close];
        return count;
    }
    [self.db close];
    return NO;
}

- (BOOL)recreateTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    int count = 0;
    NSString *newTableName = [NSString stringWithFormat:@"__sm_just_auto_recreate_%@_", tableName];
    if ([self createTable:newTableName modelClass:modelClass primaryKeys:primaryKeys]) {
        [self insertTable:newTableName anotherTable:tableName];
        [self dropTable:tableName];
        count = [self renameTable:newTableName newTableName:tableName];
    }
    return count;
}

- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    NSString *className = NSStringFromClass([modelClass class]);
    NSString *name = (tableName&&tableName.length ? tableName : className);
    NSDictionary *columns = [SMDBHelper dictionaryDbPropertiesFromModelClass:modelClass];
    NSMutableString *sqlColumns = [NSMutableString string];
    for (NSString *key in columns.allKeys) {
        NSString *type = columns[key];
        // 主键
        if ([primaryKeys containsObject:key]) {
            [sqlColumns appendFormat:@"%@ %@ PRIMARY KEY NOT NULL, ", key, type];
        } else {
            [sqlColumns appendFormat:@"%@ %@, ", key, type];
        }
    }
    [sqlColumns replaceCharactersInRange:NSMakeRange(sqlColumns.length - 2, 2) withString:@""];
    NSString *sqlQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)", name, sqlColumns];
    BOOL isSuccess = [self.db executeUpdate:sqlQuery];
    NSAssert2(isSuccess, @"创建数据库失败! %@ %@", self.db.lastErrorMessage, sqlQuery);
    [self.db close];
    return isSuccess;
}

- (BOOL)dropTable:(NSString *)tableName {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    BOOL rtn = [self.db executeUpdate:sql];
    [self.db close];
    return rtn;
}

- (BOOL)renameTable:(NSString *)tableName newTableName:(NSString *)newTableName {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@", tableName, newTableName];
    BOOL rtn = [self.db executeUpdate:sql];
    [self.db close];
    return rtn;
}

- (BOOL)alterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    NSString *sql = [self sqlFromTable:tableName];
    if (!sql || (sql.length == 0)) {
        return NO;
    }
    NSDictionary *columns = [SMDBHelper dictionaryDbPropertiesFromModelClass:modelClass];
    NSDictionary *sqlColumns = [SMDBHelper sqlColumnsFromCreateSql:sql];
    if ([sqlColumns isEqualToDictionary:columns]) {
        return NO;
    }
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    BOOL shouldDropTable = NO;
    int count = 0;
    if (sqlColumns.count > columns.count) {
        shouldDropTable = YES;
    } else {
        for (NSString *key in columns.allKeys) {
            NSString *type = [columns objectForKey:key];
            NSString *sqlType = [sqlColumns objectForKey:key];
            if (![type isEqualToString:sqlType]) {
                if (!sqlType) {
                    count += [self.db executeUpdate:[NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", tableName, key, type]];
                } else {
                    shouldDropTable = YES;
                    break;
                }
            }
        }
    }
    [self.db close];
    count = 0;
    if (shouldDropTable) {
        count = [self recreateTable:tableName modelClass:modelClass primaryKeys:primaryKeys];
    }
    return count;
}

- (BOOL)createAndAlterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    if (![self existTable:tableName]) { // 创建新表
        return [self createTable:tableName modelClass:modelClass primaryKeys:primaryKeys];
    } else if (![self existTable:tableName modelClass:modelClass]) { // 更新字段
        return [self alterTable:tableName  modelClass:modelClass primaryKeys:primaryKeys];
    }
    return NO;
}

- (int)insertTable:(NSString *)tableName anotherTable:(NSString *)anotherTable {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM %@", tableName, anotherTable];
    int count = [self.db executeUpdate:sql];
    [self.db close];
    return count;
}

- (int)insertTable:(NSString *)tableName models:(NSArray *)models {
    if (!models || !models.count) {
        return 0;
    }
    NSString *sql = [SMDBHelper sqlForInsertWithTableName:tableName model:[models firstObject]];
    int count = [self insertTableWithSql:sql models:models];
    return count;
}

- (int)insertOrReplaceTable:(NSString *)tableName models:(NSArray *)models {
    if (!models || !models.count) {
        return 0;
    }
    NSString *sql = [SMDBHelper sqlForInsertOrReplaceWithTableName:tableName model:[models firstObject]];
    int count = [self insertTableWithSql:sql models:models];
    return count;
}

- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models {
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
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[NSObject class]]) {
            BOOL isSuccess = [self.db executeUpdate:sql withParameterDictionary:[SMDBHelper dictionaryFromObject:model]];
            count += isSuccess;
        }
    }
    [self.db close];
    return count;
}

- (int)deleteTable:(NSString *)tableName {
    NSString *sql = [SMDBHelper sqlForDeleteWithTableName:tableName];
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
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[NSObject class]]) {
            NSString *sql = [SMDBHelper sqlForUpdateWithTableName:tableName model:[models firstObject] primaryKeys:primaryKeys];
            BOOL isSuccess = [self.db executeUpdate:sql withParameterDictionary:[SMDBHelper dictionaryFromObject:model]];
            count += isSuccess;
        }
    }
    [self.db close];
    return count;
}

- (int)updateTableWithSql:(NSString *)sql models:(NSArray *)models {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[NSObject class]]) {
            BOOL isSuccess = [self.db executeUpdate:sql withParameterDictionary:[SMDBHelper dictionaryFromObject:model]];
            count += isSuccess;
        }
    }
    [self.db close];
    return count;
}

- (int)updateTableWithSql:(NSString *)sql, ... {
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    BOOL isSuccess = [self.db executeUpdate:sql];
    [self.db close];
    return isSuccess;
}

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass {
    NSString *sql = [SMDBHelper sqlForSearchWithTableName:tableName];
    NSArray *rtns = [self searchTableWithSqlFillModelClass:modelClass sql:sql, nil];
    return rtns;
}

- (NSArray *)searchTableWithSqlFillModelClass:(id)modelClass sql:(NSString *)sql, ... NS_REQUIRES_NIL_TERMINATION {
    if (!sql || !sql.length) {
        return 0;
    }
    BOOL isSet = [self.db open];
    NSAssert1(isSet, @"打开数据库失败! %@\n请先创建!", self.db.lastErrorMessage);
    NSMutableArray* arrays = [NSMutableArray array];
    va_list argList;
    if (sql) {
        va_start(argList, sql);
        id arg;
        // 如果程序在此处crash, 请检查传入的参数是否为非对象
        while ((arg = va_arg(argList, id))) {
            [arrays addObject:arg];
        }
    }
    FMResultSet * set = [self.db executeQuery:sql withArgumentsInArray:arrays];
    NSMutableArray * rtns = [NSMutableArray array];
    if (modelClass) {
        while ([set next]) {
            NSDictionary *dict = [set resultDictionary];
            Class mdClass = [modelClass class];
            NSObject *model = [[mdClass alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [rtns addObject:model];
        }
    } else {
        while ([set next]) {
            NSDictionary *dict = [set resultDictionary];
            [rtns addObject:dict];
        }
    }
    [self.db close];
    return rtns;
}

#pragma mark - ()
+ (NSString *)sqlForInsertOrReplaceWithTableName:(NSString *)tableName model:(NSObject *)model {
    NSMutableString *properties = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    for (NSString *key in [self dictionaryFromObject:model].allKeys) {
        [properties appendFormat:@"%@,", key];
        [values appendFormat:@":%@,", key];
    }
    [properties replaceCharactersInRange:NSMakeRange(properties.length - 1, 1) withString:@""];
    [values replaceCharactersInRange:NSMakeRange(values.length - 1, 1) withString:@""];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES(%@)", tableName, properties, values];
    return sql;
}

+ (NSString *)sqlForInsertWithTableName:(NSString *)tableName model:(NSObject *)model {
    NSMutableString *properties = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    for (NSString *key in [self dictionaryFromObject:model].allKeys) {
        [properties appendFormat:@"%@,", key];
        [values appendFormat:@":%@,", key];
    }
    [properties replaceCharactersInRange:NSMakeRange(properties.length - 1, 1) withString:@""];
    [values replaceCharactersInRange:NSMakeRange(values.length - 1, 1) withString:@""];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO %@ (%@) VALUES(%@)", tableName, properties, values];
    return sql;
}

+ (NSString *)sqlForDeleteWithTableName:(NSString *)tableName {
    NSMutableString *sql = [NSMutableString stringWithFormat:@"DELETE FROM %@ ", tableName];
    return sql;
}

+ (NSString *)sqlForUpdateWithTableName:(NSString *)tableName model:(NSObject *)model primaryKeys:(NSArray *)primaryKeys {
    NSMutableString *set = [NSMutableString string];
    for (NSString *key in [self dictionaryFromObject:model].allKeys) {
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

+ (NSString *)sqlForSearchWithTableName:(NSString *)tableName {
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT * FROM %@ ", tableName];
    return sql;
}

+ (NSDictionary *)sqlColumnsFromCreateSql:(NSString *)sql {
    NSAssert([sql.uppercaseString hasPrefix:@"CREATE"], @"sql参数只能是基本的create sql");
    NSInteger startIndex = [sql rangeOfString:@"("].location;
    NSInteger endIndex = [sql rangeOfString:@")"].location;
    if ((startIndex != NSNotFound) && (endIndex != NSNotFound)) {
        NSString *conColumn = [sql substringWithRange:NSMakeRange(startIndex + 1, endIndex - startIndex - 1)];
        conColumn = [conColumn stringByReplacingOccurrencesOfString:@", " withString:@","];
        NSArray *comColumns = [conColumn componentsSeparatedByString:@","];
        NSMutableDictionary *columns = [NSMutableDictionary dictionary];
        for (NSString *comColumn in comColumns) {
            NSArray *coms = [comColumn componentsSeparatedByString:@" "];
            if (coms.count < 2) {
                NSAssert(NO, @"sql语句错误:%@", sql);
                return nil;
            }
            [columns setObject:coms[1] forKey:coms[0]];
        }
        return columns;
    }
    return nil;
}

+ (NSDictionary *)dictionaryDbPropertiesFromModelClass:(id)modelClass {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *className = NSStringFromClass([modelClass class]);
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
        [dict setObject:dbType forKey:attributeName];
    }
    return dict;
}

+ (NSDictionary *)dictionaryFromObject:(NSObject *)obj {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSString *key in [self dictionaryAllKeysFromObject:obj]) {
        id value = [obj valueForKey:key];
        [dict setValue:(value?value:[NSNull null]) forKey:key];
    }
    return dict;
}

+ (NSArray *)dictionaryAllKeysFromObject:(NSObject *)obj {
    NSArray * allKeys = nil;
    if (obj) {
        NSMutableArray * keys = [[NSMutableArray alloc] initWithCapacity:0];
        id classM = objc_getClass([NSStringFromClass([obj class]) UTF8String]);
        // i 计数 、  outCount 放我们的属性个数
        unsigned int outCount, i;
        // 反射得到属性的个数
        objc_property_t * properties = class_copyPropertyList(classM, &outCount);
        // 循环 得到属性名称
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            // 获得属性名称
            NSString * attributeName = [NSString stringWithUTF8String:property_getName(property)];
            [keys addObject:attributeName];
        }
        free(properties);
        allKeys = keys;
    }
    return allKeys;
}

@end

