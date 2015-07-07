//
//  SGKAccordingRelation.h
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import <Foundation/Foundation.h>
// 初始化屏幕
#define SGKScreenFrameIPaid_Portrait CGRectMake(0, 0, 768, 1024)
#define SGKScreenFrameIPhone4_Portrait CGRectMake(0, 0, 320, 480)
#define SGKScreenFrameIPhone5_Portrait CGRectMake(0, 0, 320, 568)

#define SGK_ERROR_MESSAGE_RELATIONNONE @"请使用-setAjustWithSupderAccordingFrame:或-setAutoAjustWithSupderAccordingFrame:方法初始化"

@class SGKAccording;
@interface SGKAccordingRelation : NSObject<NSCoding>

// 父视图参照(推荐选用根控制器下的view作为参照)
@property (strong, nonatomic) SGKAccording * superAccording;
// 子视图参照
@property (strong, nonatomic) NSMutableArray * subAccordings;

// 设置本对象为父视图参照 方法1
- (void)setSuperAccordingWithView:(UIView *)view frame:(CGRect)frame;
// 设置本对象为父视图参照 方法2
- (void)setSuperAccording:(SGKAccording *)superAccording;

// 设置以本对象为父视图参照的 子视图参照 方法1
- (void)addSubAccordingWithView:(UIView *)view frame:(CGRect)frame;
// 设置以本对象为父视图参照的 子视图参照 方法2
- (void)addSubAccording:(SGKAccording *)subAccording;
// 设置以本对象为父视图参照的 子视图参照 方法3
- (void)addSubAccordings:(NSArray *)accordings;

// 返回 视图参照数组 deep为NO:返回本对象的参照 deep为YES:返回本对象以及本对象以下所有参照 方法1
- (NSArray *)subAccordingsWithViews:(NSArray *)views deep:(BOOL)deep;
// 返回 视图参照数组 deep为NO:返回本对象的参照 deep为YES:返回本对象以及本对象以下所有参照 方法2
- (NSArray *)subAccordingsWithView:(UIView *)view deep:(BOOL)deep;

// 手动适配 方法1
- (void)ajustRelation;
// 手动适配 方法2
- (void)ajustRelationWithFrame:(CGRect)frame;
// 手动适配 方法3
- (void)ajustRelationWithFrame:(CGRect)frame superAccording:(SGKAccording *)superAccording subAccordings:(NSArray *)subAccordings;

// 旋转适配
- (void)ajustRelationsWithInterfaceOrientation:(UIDeviceOrientation)interfaceOrientation;

// 文件存储方式
- (void)writeToFile:(NSString *)path atomically:(BOOL)atomic;

// 转换成NSData
- (NSData *)data;

// NSData转换成对象
+ (SGKAccordingRelation *)relationWithData:(NSData *)data;

@end
