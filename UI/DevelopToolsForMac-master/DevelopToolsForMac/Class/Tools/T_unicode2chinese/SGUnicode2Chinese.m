//
//  SGUnicode2Chinese.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGUnicode2Chinese.h"
#import "SGCommonHeader.h"

@implementation SGUnicode2Chinese

- (void)execute:(id(^)())setup block:(void (^)(id result))block{
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSString * rtn = [input chineseStringByUnicode];
        block(rtn);
    }
}

@end
