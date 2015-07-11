//
//  NSString+SM.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "NSString+SM.h"

@implementation NSString (SM)

- (BOOL)sm_containsString:(NSString *)aString{
    if (SMSystemVersion > 8) {
        return [self containsString:aString];
    }
    return [self rangeOfString:aString].length;
}

@end
