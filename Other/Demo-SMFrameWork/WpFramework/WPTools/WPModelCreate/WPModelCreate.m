//
//  WPModelCreate.m
//  WisdomPark
//
//  Created by 丁治文 on 15/1/31.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//


#define INPUT_FILE @"/Users/zhangjie/Desktop/国网/SVN/WisdomParkApp/WisdomPark/WpFramework/WPTools/WPModelCreate/input.txt"
#define OUTPUT_FILE @"/Users/zhangjie/Desktop/国网/SVN/WisdomParkApp/WisdomPark/WpFramework/WPTools/WPModelCreate/output.txt"
#define OUTPUT_FILE_MODEL @"/Users/zhangjie/Desktop/国网/SVN/WisdomParkApp/WisdomPark/WpFramework/WPTools/WPModelCreate/output_model.txt"
#define OUTPUT_FILE_JSON @"/Users/zhangjie/Desktop/国网/SVN/WisdomParkApp/WisdomPark/WpFramework/WPTools/WPModelCreate/output_json.txt"
#define OUTPUT_DIRECTORY @"/Users/sghick/Desktop/OUTPUT/"

#import "WPModelCreate.h"

@implementation WPModelCreate

- (void)run{
    
//    [self formateWPModelAllWithInputFile:INPUT_FILE outputDirectory:OUTPUT_DIRECTORY];
    
    [self formateWPModelWithInputFile:INPUT_FILE outputFile:OUTPUT_FILE_MODEL];
    [self formateJsonWithInputFile:INPUT_FILE outputFile:OUTPUT_FILE_JSON];
    
//    [self formateWPDataAccessHeaderFileWithInputFile:INPUT_FILE outputFile:OUTPUT_FILE];
//    [self formateWPDataAccessSourceFileWithInputFile:INPUT_FILE outputFile:OUTPUT_FILE];
    
    
}

/**
 *  批量生成Model
 *
 *  @param inputFile       输入文件
 *  @param outputDirectory 输出文件
 */
- (void)formateWPModelAllWithInputFile:(NSString *)inputFile outputDirectory:(NSString *)outputDirectory{
    NSString * str = [NSString stringWithContentsOfFile:inputFile encoding:NSUTF8StringEncoding error:nil];
    NSArray * files = [str componentsSeparatedByString:@"#"];
    for (NSString * file in files) {
        if (!file.length) {
            continue;
        }
        NSArray * msg = [file componentsSeparatedByString:@"!"];
        NSString * directory = nil;
        for (NSString * demsg in msg) {
            if (!demsg.length) {
                continue;
            }
            if (!directory) {
                directory = [demsg stringByReplacingCharactersInRange:NSMakeRange(demsg.length-1, 1) withString:@""];
            }
            NSMutableArray * rows = [NSMutableArray arrayWithArray:[demsg componentsSeparatedByString:@"\n"]];
            NSInteger rowIndex = 0;

            NSString * headerMsgDh = @"//\n//\t%@.h\n//\tWisdomPark\n//\n//\tCreated by 丁治文 on 15/2/3.\n//\tCopyright (c) 2015年 com.wp. All rights reserved.\n//\n\n#import \"WPBaseModel.h\"\n\n@interface %@ : WPBaseModel\n%@\n@end";
            NSString * headerMsgDm = @"//\n//\t%@.m\n//\tWisdomPark\n//\n//\tCreated by 丁治文 on 15/2/3.\n//\tCopyright (c) 2015年 com.wp. All rights reserved.\n//\n\n#import \"%@.h\"\n\n@implementation %@\n\n@end";

            NSString * fileName = nil;
            NSMutableString * modelResultDh = [[NSMutableString alloc] initWithCapacity:0];

            for (NSString * row in rows) {
                if (!row.length) {
                    continue;
                }
                if (rows.count <= 2) {
                    break;
                }
                // model的类名
                if (rowIndex == 0) {
                    NSArray * modelClassName = [row componentsSeparatedByString:@"\t"];
                    fileName = [modelClassName objectAtIndex:0];
                }
                else {
                    NSString * p_property = nil;
                    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n@property (%@, nonatomic) %@ * %@;\n\n";
                    NSMutableArray * columns = [NSMutableArray arrayWithArray:[row componentsSeparatedByString:@"\t"]];
                    for (NSString * column in columns) {
                        if (!column.length) {
                            [columns removeObject:column];
                            continue;
                        }
                    }
                    if (columns.count >= 2){
                        p_property = [NSString stringWithFormat:WPFORMATE, columns[1], @"copy", @"NSString", columns[0]];
                        if (columns.count >= 3) {
                            if ([@"NSArray" isEqualToString:columns[2]]) {
                                p_property = [NSString stringWithFormat:WPFORMATE, columns[1], @"strong", @"NSArray", columns[0]];
                            }
                        }
                    }
                    [modelResultDh appendString:p_property];
                }
                rowIndex++;
            }
            if (fileName) {
                // 文件夹路径
                NSString * fileDirectory = [outputDirectory stringByAppendingPathComponent:directory];
                // .h文件路径
                NSString * fileNameDh = [fileDirectory stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"h"]];
                // .m文件路径
                NSString * fileNameDm = [fileDirectory stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"m"]];
                NSFileManager * fm = [[NSFileManager alloc] init];
                [fm createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
                headerMsgDh = [NSString stringWithFormat:headerMsgDh, fileName, fileName, modelResultDh];
                headerMsgDm = [NSString stringWithFormat:headerMsgDm, fileName, fileName, fileName];
                [headerMsgDh writeToFile:fileNameDh atomically:YES encoding:NSUTF8StringEncoding error:nil];
                [headerMsgDm writeToFile:fileNameDm atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
        }
    }
    WpLog(@"Model全部生成完成");
}

/**
 *  生成Model
 *
 *  @param inputFile  输入文件
 *  @param outputFile 输出文件
 */
- (void)formateWPModelWithInputFile:(NSString *)inputFile outputFile:(NSString *)outputFile{
    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n@property (copy, nonatomic) NSString * %@;\n\n";
    NSString * str = [NSString stringWithContentsOfFile:inputFile encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * rows = [str componentsSeparatedByString:@"\n"];
    for (NSString * row in rows) {
        /**
         *  参数名称	参数描述
         */
        NSArray * columns = [row componentsSeparatedByString:@"\t"];
        if (columns.count >= 2) {
            NSString * newContent = [NSString stringWithFormat:WPFORMATE, [columns lastObject], columns[0]];
            [outputString appendString:newContent];
        }
    }
    [outputString writeToFile:outputFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    WpLog(@"生成Model完成:%@", outputString);
}

/**
 *  生成Json
 *
 *  @param inputFile  输入文件
 *  @param outputFile 输出文件
 */
- (void)formateJsonWithInputFile:(NSString *)inputFile outputFile:(NSString *)outputFile{
    static NSString * const WPFORMATE = @"{\n%@\n}";
    NSString * str = [NSString stringWithContentsOfFile:inputFile encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * rows = [str componentsSeparatedByString:@"\n"];
    NSString * content = nil;
    for (NSString * row in rows) {
        NSString * mapFormate = @"\t\"%@\": \"%@\"";
        /**
         *  参数key	参数value
         */
        NSArray * columns = [row componentsSeparatedByString:@"\t"];
        if (columns.count >= 2) {
            NSString * newContent = [NSString stringWithFormat:mapFormate, columns[0], [columns lastObject]];
            if (!content) {
                content = newContent;
            }
            else{
                newContent = [NSString stringWithFormat:@",\n%@", newContent];
                content = [content stringByAppendingString:newContent];
            }
        }
    }
    outputString = [NSMutableString stringWithFormat:WPFORMATE, content];
    [outputString writeToFile:outputFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    WpLog(@"生成Json串完成:%@", outputString);
}


/**
 *  生成DAL头文件
 *
 *  @param inputFile  输入文件
 *  @param outputFile 输出文件
 */
- (void)formateWPDataAccessHeaderFileWithInputFile:(NSString *)inputFile outputFile:(NSString *)outputFile{
//    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n- (WPUrlRequest *)request%@;\n/**\n *  %@\n */\n+ (NSArray *)parser%@:(WPUrlRequest *)request;\n";
    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n- (WPUrlRequest *)request%@;\n";
    NSString * str = [NSString stringWithContentsOfFile:inputFile encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * rows = [str componentsSeparatedByString:@"\n"];
    NSString * lastRow = nil;
    for (NSString * row in rows) {
        if (![row hasPrefix:@"#define"]) {
            lastRow = row;
            continue;
        }
        /**
         *  注释 名称(首字母大写) 注释 名称(首字母大写)
         */
        // 注释
        NSString * rem = nil;
        // 名称
        NSString * colName = nil;
        NSString * nrow = [row stringByReplacingCharactersInRange:NSMakeRange(row.length-1, 1) withString:@""];
        NSArray * columns = [nrow componentsSeparatedByString:@"/"];
        NSString * column = [columns lastObject];
        if (column.length <= 1 && columns.count > 0) {
            column = [columns objectAtIndex:columns.count-2];
        }
        colName = [[column componentsSeparatedByString:@"\""] lastObject];
        NSString * firstChar = [colName substringToIndex:1];
        colName = [colName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstChar uppercaseString]];
        rem = [[lastRow componentsSeparatedByString:@"\t"] lastObject];
        rem = [[rem componentsSeparatedByString:@"//"] lastObject];
        rem = [[rem componentsSeparatedByString:@"."] lastObject];
        if (colName) {
            NSString * newContent = [NSString stringWithFormat:WPFORMATE, rem, colName];
            [outputString appendString:newContent];
        }
    }
    [outputString writeToFile:outputFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    WpLog(@"生成DataAccessHeader完成:%@", outputString);
}

/**
 *  生成DAL源文件
 *
 *  @param inputFile  输入文件
 *  @param outputFile 输出文件
 */
- (void)formateWPDataAccessSourceFileWithInputFile:(NSString *)inputFile outputFile:(NSString *)outputFile{
//    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n- (WPUrlRequest *)request%@{\n%@\n}\n/**\n *  %@\n */\n+ (NSArray *)parser%@:(WPUrlRequest *)request{\n%@\n}\n";
    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n- (WPUrlRequest *)request%@{\n%@\n}\n";
    NSString * str = [NSString stringWithContentsOfFile:inputFile encoding:NSUTF8StringEncoding error:nil];
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * rows = [str componentsSeparatedByString:@"\n"];
    NSString * lastRow = nil;
    for (NSString * row in rows) {
        if (![row hasPrefix:@"#define"]) {
            lastRow = row;
            continue;
        }
        /**
         *  注释 名称(首字母大写) 注释 名称(首字母大写)
         */
        // 注释
        NSString * rem = nil;
        // 名称
        NSString * colName = nil;
        NSString * nrow = [row stringByReplacingCharactersInRange:NSMakeRange(row.length-1, 1) withString:@""];
        NSArray * columns = [nrow componentsSeparatedByString:@"/"];
        NSString * column = [columns lastObject];
        if (column.length <= 1 && columns.count > 0) {
            column = [columns objectAtIndex:columns.count-2];
        }
        colName = [[column componentsSeparatedByString:@"\""] lastObject];
        NSString * firstChar = [colName substringToIndex:1];
        colName = [colName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstChar uppercaseString]];
        rem = [[lastRow componentsSeparatedByString:@"\t"] lastObject];
        rem = [[rem componentsSeparatedByString:@"//"] lastObject];
        rem = [[rem componentsSeparatedByString:@"."] lastObject];
        
        NSString * url = [[row componentsSeparatedByString:@" "] objectAtIndex:1];
        NSString * request = [NSString stringWithFormat:@"\tWPUrlRequest * request = [self wpUrlRequest];\n\trequest.key = @\"request%@\";\n\trequest.requestMethod = requestMethodPost;\n\trequest.urlString = %@;\n\tNSDictionary * parmDict = nil;\n\trequest.paramsDict = parmDict;\n\trequest.parserReturnType = parserReturnTypeArray;\n\trequest.parserMapper = @{@\"WPHttpResultModel\": @\"info\"};\n\treturn request;",colName, url];
        if (colName) {
            NSString * newContent = [NSString stringWithFormat:WPFORMATE, rem, colName, request];
            [outputString appendString:newContent];
        }
    }
    [outputString writeToFile:outputFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    WpLog(@"生成DataAccessSource完成:%@", outputString);
}

@end
