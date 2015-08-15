//
//  NSString+SM.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "NSString+SM.h"
#import "UIHeader.h"
#import "UIDevice+SM.h"

@implementation NSString (SM)

- (BOOL)sm_containsString:(NSString *)aString{
    if (SMSystemVersion > 8) {
        return [self containsString:aString];
    }
    return [self rangeOfString:aString].length;
}

#pragma mark - unicode
- (NSString *)chineseStringByUnicode {
    NSString * rtn = nil;
    NSString * tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString * tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString * tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData * tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    rtn = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    return rtn;
}

- (NSString *)unicodeStringByChinese {
    NSString * rtn = @"";
    NSString * tempStr1 = [self stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
    if ([tempStr1 hasPrefix:@"%FF%FE"] && (tempStr1.length%6 == 0)) {
        tempStr1 = [tempStr1 stringByReplacingOccurrencesOfString:@"%FF%FE" withString:@""];
        NSArray * tempArr = [tempStr1 componentsSeparatedByString:@"%"];
        NSArray * tempReverseArr = [self reverse:tempArr];
        NSString * newSubStr = nil;
        for (int i = 0; i < tempReverseArr.count; i++) {
            if (i%2 == 0) {
                newSubStr = [@"\\U" stringByAppendingString:tempReverseArr[i]];
            }
            else{
                newSubStr = [newSubStr stringByAppendingString:tempReverseArr[i]];
                rtn = [rtn stringByAppendingString:newSubStr];
            }
        }
    }
    return rtn;
}

#pragma mark ()
- (NSArray *)reverse:(NSArray *)array{
    NSMutableArray * exArr = [NSMutableArray arrayWithArray:array];
    [exArr removeObjectAtIndex:0];
    for (int i = 0; i < exArr.count; i++) {
        if (i%2 == 1) {
            [exArr exchangeObjectAtIndex:(i - 1) withObjectAtIndex:i];
        }
    }
    return exArr;
}

#pragma mark - 中文拼音
- (NSString *)stringTransformMandarinLatin {
    NSMutableString *source = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return source;
}

- (NSString *)stringInitial {
    NSMutableString * rtn = [[NSMutableString alloc] initWithCapacity:0];
    for (int i = 0; i < self.length; i++) {
        NSString * ch = [self substringWithRange:NSMakeRange(i, 1)];
        NSString * rtnCh = [[ch stringTransformMandarinLatin] substringToIndex:1];
        [rtn appendString:rtnCh];
    }
    return rtn;
}

- (BOOL)containsIntelligentString:(NSString *)aString {
    // 缩写匹配
    if ([self containsAbbreviteString:aString]) {
        return YES;
    }
    // 全写匹配
    if ([self containsFullString:aString]) {
        return YES;
    }
    return NO;
}

- (BOOL)containsAbbreviteString:(NSString *)aString {
    NSString * cs1 = [[self stringInitial] stringTrimSpace];
    NSString * cs2 = [[aString stringInitial] stringTrimSpace];
    return [cs1 containsString:cs2];
}

- (BOOL)containsFullString:(NSString *)aString {
    NSString * cs1 = [[self stringTransformMandarinLatin] stringTrimSpace];
    NSString * cs2 = [[aString stringInitial] stringTrimSpace];
    return [cs1 containsString:cs2];
}

#pragma mark - 字符串操作
- (NSString *)stringTrimSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
