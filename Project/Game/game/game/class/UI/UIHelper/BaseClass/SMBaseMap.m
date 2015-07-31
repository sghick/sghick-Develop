//
//  SMBaseMap.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMBaseMap.h"

@implementation SMBaseMap

+ (instancetype)map {
    SMBaseMap *map = [[SMBaseMap alloc] initWithFrame:SMScreenBounds];
    map.userInteractionEnabled = NO;
    return map;
}

@end
