//
//  SMRunScene001.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMRunScene001.h"
#import "SMRunMap001.h"

@implementation SMRunScene001

+ (instancetype)scene {
    SMRunScene001 *scene = [super scene];
    SMRunMap001 *map001 = [SMRunMap001 map];
    [scene addMap:map001];
    
    
    
    return scene;
}

@end
