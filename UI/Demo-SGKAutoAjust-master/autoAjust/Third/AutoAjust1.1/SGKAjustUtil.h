//
//  SGKAjustUtil.h
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SGK_CGRectIsNoneOrEmpty(frame) CGRectIsEmpty(frame)||CGRectIsEmpty(frame)||CGRectIsEmpty(frame)?YES:NO

@interface SGKAjustUtil : NSObject
// rect*newRect/oldRect
+ (CGRect)proportionRectWithRect:(CGRect)rect newSuperFrame:(CGRect)newRect oldSuperRect:(CGRect)oldRect;

@end
