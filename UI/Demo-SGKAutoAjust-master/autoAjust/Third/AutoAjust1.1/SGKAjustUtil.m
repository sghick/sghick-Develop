//
//  SGKAjustUtil.m
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import "SGKAjustUtil.h"

@implementation SGKAjustUtil

// rect*newRect/oldRect
+ (CGRect)proportionRectWithRect:(CGRect)rect newSuperFrame:(CGRect)newRect oldSuperRect:(CGRect)oldRect{
    CGRect rtnRect = CGRectZero;
    rtnRect.origin.x = (newRect.size.width+newRect.origin.x)/(oldRect.size.width+oldRect.origin.x)*rect.origin.x;
    rtnRect.origin.y = (newRect.size.height+newRect.origin.y)/(oldRect.size.height+oldRect.origin.y)*rect.origin.y;
    rtnRect.size.width = newRect.size.width/oldRect.size.width*rect.size.width;
    rtnRect.size.height = newRect.size.height/oldRect.size.height*rect.size.height;
    return rtnRect;
}

@end
