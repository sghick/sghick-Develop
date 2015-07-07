//
//  SGFormateModel.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGFormateModel.h"

@implementation SGFormateModel

- (void)execute:(id (^)())setup block:(void (^)(id))block{
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSString * rtn = [self formateWPModelWithInputString:input];
        block(rtn);
    }
}

- (NSString *)formateWPModelWithInputString:(NSString *)inputString{
    static NSString * const WPFORMATE = @"\n/**\n *  %@\n */\n@property (copy, nonatomic) NSString * %@;\n\n";
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * rows = [inputString componentsSeparatedByString:@"\n"];
    for (NSString * row in rows) {
        // 参数名称	参数描述
        NSArray * columns = [row componentsSeparatedByString:@"\t"];
        if (columns.count >= 2) {
            NSString * newContent = [NSString stringWithFormat:WPFORMATE, [columns lastObject], columns[0]];
            [outputString appendString:newContent];
        }
    }
    return outputString;
}

@end
