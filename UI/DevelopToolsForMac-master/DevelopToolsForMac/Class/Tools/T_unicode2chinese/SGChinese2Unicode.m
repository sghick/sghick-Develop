//
//  SGChinese2Unicode.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGChinese2Unicode.h"
#import "SGCommonHeader.h"

@implementation SGChinese2Unicode

- (void)execute:(id(^)())setup block:(void (^)(id result))block{
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSString * rtn = [input unicodeStringByChinese];
        block(rtn);
    }
}

@end
