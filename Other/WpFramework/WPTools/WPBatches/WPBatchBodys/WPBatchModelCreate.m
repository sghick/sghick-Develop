//
//  WPBatchModelCreate.m
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBatchModelCreate.h"

@implementation WPBatchModelCreate

- (void)setUp{
    self.inputPath = @"/Users/sghick/Desktop/INPUT/modelCreateInput.txt";
    self.outputPath = @"/Users/sghick/Desktop/OUTPUT/modelCreateInput.txt";
}

- (void)excute{
    [self formateWPModelAllWithInputFile:self.inputFilePath outputDirectory:self.outputDirectoryPath];
}

- (void)tearDown{
    
}

#pragma mark - myCode
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
        NSString * proFile = [file stringByReplacingOccurrencesOfString:@"!/t" withString:@"!"];
        NSArray * msg = [proFile componentsSeparatedByString:@"!"];
        NSString * directory = nil;
        for (NSString * demsg in msg) {
            if (!demsg.length) {
                continue;
            }
            if (!directory) {
                directory = [demsg stringByReplacingCharactersInRange:NSMakeRange(demsg.length-1, 1) withString:@""];
            }
            NSMutableArray * rows = [NSMutableArray arrayWithArray:[demsg componentsSeparatedByString:@"\r"]];
            if (rows.count <= 1) {
                rows = [NSMutableArray arrayWithArray:[demsg componentsSeparatedByString:@"\t"]];
            }
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

@end
