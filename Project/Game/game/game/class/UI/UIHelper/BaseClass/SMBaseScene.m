//
//  SMBaseScene.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMBaseScene.h"

@implementation SMBaseScene

+ (instancetype)scene {
    SMBaseScene *scene = [[SMBaseScene alloc] initWithFrame:SMScreenBounds];
    return scene;
}

#pragma mark - seeter
- (void)addSetting:(SMBaseSetting *)setting {
    _seeting = setting;
    [self addSubview:setting];
}

- (void)addMap:(SMBaseMap *)map {
    _map = map;
    [self addSubview:map];
}

- (void)addConstruct:(SMBaseConstruct *)construct {
    _construct = construct;
    [self addSubview:construct];
}

- (void)addMonster:(SMBaseMonster *)monster {
    _monster = monster;
    [self addSubview:monster];
}

- (void)addRole:(SMBaseRole *)role {
    _role = role;
    [self addSubview:role];
}

@end
