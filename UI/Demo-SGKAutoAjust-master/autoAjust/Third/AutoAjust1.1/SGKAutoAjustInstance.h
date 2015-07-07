//
//  SGKAutoAjustInstance.h
//  autoAjust
//
//  Created by qf on 14-11-27.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGKAjustUtil.h"
#import "SGKAccording.h"
#import "SGKAccordingRelation.h"

@interface SGKAutoAjustInstance : NSObject

@property (strong, nonatomic, readonly) NSMutableArray * relations;

// 单例
+ (instancetype)sharedAutoAjustInstance;

// 添加某父视图下的relation
- (void)addRelation:(SGKAccordingRelation *)relation;

// 取得某父视图下的relation
- (SGKAccordingRelation *)relationWithSuperView:(UIView *)view;

// 移除relation,请在对象销毁前移除relation,否则会造成内存泄漏
- (void)removeRelationWithSuperView:(UIView *)view;

@end
