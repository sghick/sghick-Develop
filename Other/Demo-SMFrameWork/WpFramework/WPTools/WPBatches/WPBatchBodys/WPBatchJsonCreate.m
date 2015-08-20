//
//  WPBatchJsonCreate.m
//  WisdomPark
//
//  Created by 丁治文 on 15/2/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBatchJsonCreate.h"

@implementation WPBatchJsonCreate

- (void)setUp{
    self.inputPath = @"/Users/sghick/Desktop/INPUT/jsonCreateInput.txt";
    self.outputPath = @"/Users/sghick/Desktop/OUTPUT/jsonCreateOutput.txt";
}

- (void)excute{
    [self formateJsonWithInputFile:self.inputFilePath outputFile:self.outputFilePath];
}

- (void)tearDown{
    
}

#pragma mark - myCode
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
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@"\n"];
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

@end
