//
//  SGKAutoAjustInstance.m
//  autoAjust
//
//  Created by qf on 14-11-27.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import "SGKAutoAjustInstance.h"

@implementation SGKAutoAjustInstance

@synthesize relations = _relations;

// 单例
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        static SGKAutoAjustInstance * instance = nil;
        static dispatch_once_t predicate = 0l;
        dispatch_once(&predicate, ^{
            instance = [[super allocWithZone:zone] init];
        });
        return instance;
    }
}

// 单例
+ (instancetype)sharedAutoAjustInstance{
    @synchronized(self){
        static SGKAutoAjustInstance * instance = nil;
        static dispatch_once_t predicate = 0l;
        dispatch_once(&predicate, ^{
            instance = [[super alloc] init];
        });
        return instance;
    }
}

// 添加某父视图下的relation
- (void)addRelation:(SGKAccordingRelation *)relation{
    if (!_relations) {
        _relations = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if (![self relationWithSuperView:relation.superAccording.view]) {
        [_relations addObject:relation];
    }
}

// 取得某父视图下的relation
- (SGKAccordingRelation *)relationWithSuperView:(UIView *)view{
    for (SGKAccordingRelation * relation in _relations) {
        if (relation.superAccording.view == view) {
            return relation;
        }
    }
    return nil;
}

// 移除relation,请在对象销毁前移除relation,否则会造成内存泄漏
- (void)removeRelationWithSuperView:(UIView *)view{
    for (SGKAccordingRelation * relation in _relations) {
        if (relation.superAccording.view == view) {
            [_relations removeObject:relation];
        }
    }
}

@end
