//
//  SMBaseScene.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMBaseSetting.h"
#import "SMBaseMap.h"
#import "SMBaseConstruct.h"
#import "SMBaseMonster.h"
#import "SMBaseRole.h"

@protocol SMBaseSceneProtocol <NSObject>


@end

@interface SMBaseScene : UIView

// 设置
@property (strong, readonly, nonatomic) SMBaseSetting *seeting;
// 地图
@property (strong, readonly, nonatomic) SMBaseMap *map;
// 建筑
@property (strong, readonly, nonatomic) SMBaseConstruct *construct;
// 怪物
@property (strong, readonly, nonatomic) SMBaseMonster *monster;
// 角色
@property (strong, readonly, nonatomic) SMBaseRole *role;

+ (instancetype)scene;

#pragma mark - seeter
- (void)addSetting:(SMBaseSetting *)setting;
- (void)addMap:(SMBaseMap *)map;
- (void)addConstruct:(SMBaseConstruct *)construct;
- (void)addMonster:(SMBaseMonster *)monster;
- (void)addRole:(SMBaseRole *)role;

@end
