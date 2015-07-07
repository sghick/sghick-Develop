//
//  UIView+SGKAutoAjust.m
//  用代码实现计算器布局_Masonry
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import "UIView+SGKAutoAjust.h"

@implementation UIView (SGKAutoAjust)

// 添加本视图为父视图参照并自动适配,推荐用视图控制器为父视图参照
- (SGKAccordingRelation *)setAutoAjustWithSupderAccordingFrame:(CGRect)frame{
    SGKAccordingRelation * relation = [[SGKAutoAjustInstance sharedAutoAjustInstance] relationWithSuperView:self];
    if (!relation) {
        relation = [[SGKAccordingRelation alloc] init];
        SGKAccording * superAccording = [[SGKAccording alloc] initWithView:self frame:frame];
        [relation setSuperAccording:superAccording];
    }
    NSArray * arr = [relation subAccordingsWithViews:self.subviews deep:YES];
    [relation addSubAccordings:arr];
    [relation ajustRelation];
    [[SGKAutoAjustInstance sharedAutoAjustInstance] addRelation:relation];
    return relation;
}

// 添加本视图为父视图参照,需要手动适配
- (SGKAccordingRelation *)setAjustWithSupderAccordingFrame:(CGRect)frame{
    SGKAccordingRelation * relation = [[SGKAutoAjustInstance sharedAutoAjustInstance] relationWithSuperView:self];
    if (!relation) {
        relation = [[SGKAccordingRelation alloc] init];
        SGKAccording * superAccording = [[SGKAccording alloc] initWithView:self frame:frame];
        [relation setSuperAccording:superAccording];
        [[SGKAutoAjustInstance sharedAutoAjustInstance] addRelation:relation];
    }
    return relation;
}

// 添加子视图参照,并适配
- (SGKAccordingRelation *)addSubAccordingWithView:(UIView *)view frame:(CGRect)frame{
    SGKAccordingRelation * relation = [[SGKAutoAjustInstance sharedAutoAjustInstance] relationWithSuperView:self];
    if (relation) {
        CGRect defaultFrame = frame;
        if (SGK_CGRectIsNoneOrEmpty(frame)) {
            defaultFrame = view.frame;
        }
        NSArray * subAccordings = [relation subAccordingsWithView:view deep:YES];
        [relation addSubAccordings:subAccordings];
        [relation ajustRelation];
    }
    else{
        NSLog(SGK_ERROR_MESSAGE_RELATIONNONE);
    }
    return relation;
}

// 手动适配,在控制器的-viewWillAppear:方法中添加此方法
- (void)autoAjustRelation{
    SGKAccordingRelation * relation = [[SGKAutoAjustInstance sharedAutoAjustInstance] relationWithSuperView:self];
    if (relation) {
        [relation ajustRelation];
    }
    else{
        NSLog(SGK_ERROR_MESSAGE_RELATIONNONE);
    }
}

// 旋转适配,在控制器的-willAnimateRotationToInterfaceOrientation:方法中添加此方法
- (void)autoAjustRelationWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    SGKAccordingRelation * relation = [[SGKAutoAjustInstance sharedAutoAjustInstance] relationWithSuperView:self];
    if (relation) {
        [relation ajustRelationsWithInterfaceOrientation:interfaceOrientation];
    }
    else{
        NSLog(SGK_ERROR_MESSAGE_RELATIONNONE);
    }
}

// 移除relation,请在对象销毁前移除relation,否则会造成内存泄漏
- (void)removeRelation{
    [[SGKAutoAjustInstance sharedAutoAjustInstance] removeRelationWithSuperView:self];
}

@end
