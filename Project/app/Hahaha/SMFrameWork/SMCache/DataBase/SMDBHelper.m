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
        NSLog(@"dbPath:%@", DBPath);
        FMDatabaseQueue *dbQueue = [[FMDatabaseQueue alloc] initWithPath:DBPath];
        _dbQueue = dbQueue;
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

#pragma mark - Object Methods ExcuteInQueue
- (NSString *)sqlFromTable:(NSString *)tableName {
    __block NSString *rtn = nil;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper sqlFromTable:tableName inDB:db];
    }];
    return rtn;
}

- (BOOL)existTable:(NSString *)tableName {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper existTable:tableName inDB:db];
    }];
    return NO;
}


- (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper existTable:tableName modelClass:modelClass inDB:db];
    }];
    return NO;
}

- (BOOL)recreateTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper recreateTable:tableName modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    }];
    return NO;
}

- (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper createTable:tableName modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    }];
    return NO;
}

- (BOOL)dropTable:(NSString *)tableName {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper dropTable:tableName inDB:db];
    }];
    return NO;
}

- (BOOL)renameTable:(NSString *)tableName newTableName:(NSString *)newTableName {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper renameTable:tableName newTableName:newTableName inDB:db];
    }];
    return NO;
}

- (BOOL)alterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper alterTable:tableName modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    }];
    return NO;
}

- (BOOL)createAndAlterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys {
    __block BOOL rtn = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtn = [SMDBHelper createAndAlterTable:tableName modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    }];
    return NO;
}

- (int)insertTable:(NSString *)tableName anotherTable:(NSString *)anotherTable {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper insertTable:tableName anotherTable:anotherTable inDB:db];
    }];
    return count;
}

- (int)insertTable:(NSString *)tableName models:(NSArray *)models {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper insertTable:tableName models:models inDB:db];
    }];
    return count;
}

- (int)insertOrReplaceTable:(NSString *)tableName models:(NSArray *)models {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper insertOrReplaceTable:tableName models:models inDB:db];
    }];
    return count;
}

- (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper insertTableWithSql:sql models:models inDB:db];
    }];
    return count;
}

- (int)deleteTable:(NSString *)tableName {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper deleteTable:tableName inDB:db];
    }];
    return count;
}

- (int)deleteTableWithSql:(NSString*)sql params:(NSArray *)params {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper deleteTableWithSql:sql params:params inDB:db];
    }];
    return count;
}

- (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper updateTable:tableName models:models primaryKeys:primaryKeys inDB:db];
    }];
    return count;
}

- (int)updateTableWithSql:(NSString *)sql params:(NSArray *)params {
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        count = [SMDBHelper updateTableWithSql:sql params:params inDB:db];
    }];
    return count;
}

- (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass {
    __block NSArray *rtns = nil;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtns = [SMDBHelper searchTable:tableName modelClass:modelClass inDB:db];
    }];
    return rtns;
}

- (NSArray *)searchTableWithSql:(NSString *)sql params:(NSArray *)params modelClass:(id)modelClass {
    __block NSArray *rtns = nil;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        rtns = [SMDBHelper searchTableWithSql:sql params:params modelClass:modelClass inDB:db];
    }];
    return rtns;
}

#pragma mark - Static Methods
+ (NSString *)sqlFromTable:(NSString *)tableName inDB:(FMDatabase *)db {
    NSString *rtn = nil;
    FMResultSet *rs = [db executeQuery:@"select * from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        rtn = [rs stringForColumn:@"sql"];
        break;
    }
    return rtn;
}

+ (BOOL)existTable:(NSString *)tableName inDB:(FMDatabase *)db {
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        return count;
    }
    return NO;
}


+ (BOOL)existTable:(NSString *)tableName modelClass:(id)modelClass inDB:(FMDatabase *)db {
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        return count;
    }
    return NO;
}

+ (BOOL)recreateTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db {
    int count = 0;
    NSString *newTableName = [NSString stringWithFormat:@"__sm_just_auto_recreate_%@_", tableName];
    if ([self createTable:newTableName modelClass:modelClass primaryKeys:primaryKeys inDB:db]) {
        [self insertTable:newTableName anotherTable:tableName inDB:db];
        [self dropTable:tableName inDB:db];
        count = [self renameTable:newTableName newTableName:tableName inDB:db];
    }
    return count;
}

+ (BOOL)createTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db {
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
    BOOL isSuccess = [db executeUpdate:sqlQuery];
    NSAssert2(isSuccess, @"创建数据库失败! %@ %@", db.lastErrorMessage, sqlQuery);
    return isSuccess;
}

+ (BOOL)dropTable:(NSString *)tableName inDB:(FMDatabase *)db {
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    BOOL rtn = [db executeUpdate:sql];
    return rtn;
}

+ (BOOL)renameTable:(NSString *)tableName newTableName:(NSString *)newTableName inDB:(FMDatabase *)db {
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@", tableName, newTableName];
    BOOL rtn = [db executeUpdate:sql];
    return rtn;
}

+ (BOOL)alterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db {
    NSString *sql = [self sqlFromTable:tableName inDB:db];
    if (!sql || (sql.length == 0)) {
        return NO;
    }
    NSDictionary *columns = [SMDBHelper dictionaryDbPropertiesFromModelClass:modelClass];
    NSDictionary *sqlColumns = [SMDBHelper sqlColumnsFromCreateSql:sql];
    if ([sqlColumns isEqualToDictionary:columns]) {
        return NO;
    }
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
                    count += [db executeUpdate:[NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", tableName, key, type]];
                } else {
                    shouldDropTable = YES;
                    break;
                }
            }
        }
    }
    count = 0;
    if (shouldDropTable) {
        count = [self recreateTable:tableName modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    }
    return count;
}

+ (BOOL)createAndAlterTable:(NSString *)tableName modelClass:(id)modelClass primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db {
    if (![self existTable:tableName inDB:db]) { // 创建新表
        return [self createTable:tableName modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    } else if (![self existTable:tableName modelClass:modelClass inDB:db]) { // 更新字段
        return [self alterTable:tableName  modelClass:modelClass primaryKeys:primaryKeys inDB:db];
    }
    return NO;
}

+ (int)insertTable:(NSString *)tableName anotherTable:(NSString *)anotherTable inDB:(FMDatabase *)db {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM %@", tableName, anotherTable];
    int count = [db executeUpdate:sql];
    return count;
}

+ (int)insertTable:(NSString *)tableName models:(NSArray *)models inDB:(FMDatabase *)db {
    if (!models || !models.count) {
        return 0;
    }
    NSString *sql = [SMDBHelper sqlForInsertWithTableName:tableName model:[models firstObject]];
    int count = [self insertTableWithSql:sql models:models inDB:db];
    return count;
}

+ (int)insertOrReplaceTable:(NSString *)tableName models:(NSArray *)models inDB:(FMDatabase *)db {
    if (!models || !models.count) {
        return 0;
    }
    NSString *sql = [SMDBHelper sqlForInsertOrReplaceWithTableName:tableName model:[models firstObject]];
    int count = [self insertTableWithSql:sql models:models inDB:db];
    return count;
}

+ (int)insertTableWithSql:(NSString *)sql models:(NSArray *)models inDB:(FMDatabase *)db {
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
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[NSObject class]]) {
            BOOL isSuccess = [db executeUpdate:sql withParameterDictionary:[SMDBHelper dictionaryFromObject:model]];
            count += isSuccess;
        }
    }
    return count;
}

+ (int)deleteTable:(NSString *)tableName inDB:(FMDatabase *)db {
    NSString *sql = [SMDBHelper sqlForDeleteWithTableName:tableName];
    int count = [self deleteTableWithSql:sql params:nil inDB:db];
    return count;
}

+ (int)deleteTableWithSql:(NSString *)sql params:(NSArray *)params inDB:(FMDatabase *)db {
    BOOL isSuccess = [db executeUpdate:sql withArgumentsInArray:params];
    return isSuccess;
}

+ (int)updateTable:(NSString *)tableName models:(NSArray *)models primaryKeys:(NSArray *)primaryKeys inDB:(FMDatabase *)db {
    if (!models || !models.count) {
        return 0;
    }
    int count = 0;
    for (id model in models) {
        if ([model isKindOfClass:[NSObject class]]) {
            NSString *sql = [SMDBHelper sqlForUpdateWithTableName:tableName model:[models firstObject] primaryKeys:primaryKeys];
            BOOL isSuccess = [db executeUpdate:sql withParameterDictionary:[SMDBHelper dictionaryFromObject:model]];
            count += isSuccess;
        }
    }
    return count;
}

+ (int)updateTableWithSql:(NSString *)sql params:(NSArray *)params inDB:(FMDatabase *)db {
    BOOL isSuccess = [db executeUpdate:sql withArgumentsInArray:params];
    return isSuccess;
}

+ (NSArray *)searchTable:(NSString *)tableName modelClass:(id)modelClass inDB:(FMDatabase *)db {
    NSString *sql = [SMDBHelper sqlForSearchWithTableName:tableName];
    NSArray *rtns = [self searchTableWithSql:sql params:nil modelClass:modelClass inDB:db];
    return rtns;
}

+ (NSArray *)searchTableWithSql:(NSString *)sql params:(NSArray *)params modelClass:(id)modelClass inDB:(FMDatabase *)db {
    if (!sql || !sql.length) {
        return 0;
    }
    FMResultSet * set = [db executeQuery:sql withArgumentsInArray:params];
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
    return rtns;
}

#pragma mark - Utils
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

