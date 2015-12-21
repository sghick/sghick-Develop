//
//  NSString+SG.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/11.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SG)

#pragma mark - unicode

/**
 *  unicode转成中文
 *
 *  @param unicode unicode
 *
 *  @return 中文
 */
- (NSString *)chineseStringByUnicode;

/**
 *  中文转成unicode
 *
 *  @param string 中文
 *
 *  @return unicode
 */
- (NSString *)unicodeStringByChinese;

#pragma mark - 中文拼音

/**
 *  中文转成拼音
 */
- (NSString *)stringTransformMandarinLatin;

/**
 *  取得每个中文的首字母
 */
- (NSString *)stringInitial;

/**
 *  智能匹配
 */
- (BOOL)containsIntelligentString:(NSString *)aString;

/**
 *  全写匹配
 */
- (BOOL)containsFullString:(NSString *)aString;

/**
 *  缩写匹配
 */
- (BOOL)containsAbbreviteString:(NSString *)aString;

#pragma mark - 字符串操作

/**
 *  删除字符串中的空格
 */
- (NSString *)stringTrimSpace;

@end
