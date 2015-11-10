//
//  SGFormateJson.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGFormateJson.h"

@implementation SGFormateJson

- (void)execute:(id (^)())setup block:(void (^)(id))block{
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSString * rtn = [self formateJsonWithInputString:input];
        block(rtn);
    }
}

- (NSString *)formateJsonWithInputString:(NSString *)inputString{
    static NSString * const WPFORMATE = @"{\n%@\n}";
    NSArray * rows = [inputString componentsSeparatedByString:@"\n"];
    NSString * content = nil;
    for (NSString * row in rows) {
        NSString * mapFormate = @"\t\"%@\": \"%@\"";
        // 参数key	参数value
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
    NSString *outputString = [NSString stringWithFormat:WPFORMATE, content];
    return outputString;
}

@end
