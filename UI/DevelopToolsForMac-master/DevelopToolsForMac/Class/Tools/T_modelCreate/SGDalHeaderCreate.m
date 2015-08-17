//
//  SGDalHeaderCreate.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGDalHeaderCreate.h"

@implementation SGDalHeaderCreate

- (void)execute:(id (^)())setup block:(void (^)(id))block{
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSString * rtn = [self formateWPDataAccessHeaderFileWithInputString:input];
        block(rtn);
    }
}

- (NSString *)formateWPDataAccessHeaderFileWithInputString:(NSString *)inputString {
    //    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n- (WPUrlRequest *)request%@;\n/**\n *  %@\n */\n+ (NSArray *)parser%@:(WPUrlRequest *)request;\n";
    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n- (WPUrlRequest *)request%@;\n";
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * rows = [inputString componentsSeparatedByString:@"\n"];
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
    return outputString;
}

@end
