//
//  SGKAccordingRelation.m
//  autoAjust
//
//  Created by qf on 14-11-26.
//  Copyright (c) 2014年 sghick. All rights reserved.
//

#import "SGKAccordingRelation.h"
#import "SGKAccording.h"
#import "SGKAjustUtil.h"

@implementation SGKAccordingRelation

@synthesize superAccording = _superAccording;
@synthesize subAccordings = _subAccordings;

// 初始化构造方法
- (id)init{
    self = [super init];
    if (self) {
        _subAccordings = [[NSMutableArray alloc] initWithCapacity:0];
        _superAccording = [[SGKAccording alloc] init];
    }
    return self;
}

// 设置本对象为父视图参照 方法1
- (void)setSuperAccordingWithView:(UIView *)view frame:(CGRect)frame{
    SGKAccording * according = [[SGKAccording alloc] initWithView:view frame:frame];
    _superAccording = nil;
    _superAccording = according;
}

// 设置本对象为父视图参照 方法2
- (void)setSuperAccording:(SGKAccording *)superAccording{
    _superAccording = nil;
    _superAccording = superAccording;
}

// 设置以本对象为父视图参照的 子视图参照 方法1
- (void)addSubAccordingWithView:(UIView *)view frame:(CGRect)frame{
    SGKAccording * according = [[SGKAccording alloc] initWithView:view frame:frame];
    if (![according isExsitInArray:_subAccordings]) {
        [_subAccordings addObject:according];
    }
}

// 设置以本对象为父视图参照的 子视图参照 方法2
- (void)addSubAccording:(SGKAccording *)subAccording{
    if (![subAccording isExsitInArray:_subAccordings]) {
        [_subAccordings addObject:subAccording];
    }
}

// 设置以本对象为父视图参照的 子视图参照 方法3
- (void)addSubAccordings:(NSArray *)accordings{
    NSArray * newArr = [SGKAccording accordingsWithNoRepeat:accordings];
    for (SGKAccording * according in newArr) {
        [self addSubAccording:according];
    }
}

// 返回 视图参照数组 deep为NO:返回本对象的参照 deep为YES:返回本对象以及本对象以下所有参照 方法1
- (NSArray *)subAccordingsWithViews:(NSArray *)views deep:(BOOL)deep{
    NSMutableArray * rtnArr = [[NSMutableArray alloc] init];
    for (UIView * view in views) {
        if ([view isMemberOfClass:NSClassFromString(@"_UILayoutGuide")]) {
            continue;
        }
        [rtnArr addObjectsFromArray:[self subAccordingsWithView:view deep:deep]];
    }
    return rtnArr;
}

// 返回 视图参照数组 deep为NO:返回本对象的参照 deep为YES:返回本对象以及本对象以下所有参照 方法2
- (NSArray *)subAccordingsWithView:(UIView *)view deep:(BOOL)deep{
    NSMutableArray * rtnArr = [[NSMutableArray alloc] init];
    SGKAccording * selfAccording = [[SGKAccording alloc] initWithView:view frame:view.frame];
    [rtnArr addObject:selfAccording];
    if (deep) {
        for (UIView * subView in view.subviews) {
            SGKAccording * subAccording = [[SGKAccording alloc] initWithView:subView frame:subView.frame];
            [rtnArr addObject:subAccording];
            if (view.subviews.count) {
                [rtnArr addObjectsFromArray:[self subAccordingsWithView:subView deep:deep]];
            }
        }
        return rtnArr;
    }
    return rtnArr;
}

// 手动适配 方法1
- (void)ajustRelation{
    [self ajustRelationWithFrame:_superAccording.view.frame];
}

// 手动适配 方法2
- (void)ajustRelationWithFrame:(CGRect)frame{
    [self ajustRelationWithFrame:frame superAccording:_superAccording subAccordings:_subAccordings];
}

// 手动适配 方法3
- (void)ajustRelationWithFrame:(CGRect)frame superAccording:(SGKAccording *)superAccording subAccordings:(NSArray *)subAccordings{
    for (SGKAccording * subAccor in subAccordings) {        
        CGRect nRect = [SGKAjustUtil proportionRectWithRect:subAccor.frame newSuperFrame:frame oldSuperRect:superAccording.frame];
        subAccor.view.frame = nRect;
    }
}

// 旋转适配
- (void)ajustRelationsWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    CGRect sRect = _superAccording.view.frame;
    CGRect rect = sRect;
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        rect.size.width = sRect.size.height;
        rect.size.height = sRect.size.width;
    }
    if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        rect.size.width = sRect.size.height;
        rect.size.height = sRect.size.width;
    }
    [self ajustRelationWithFrame:rect];
}

#pragma mark- NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.superAccording forKey:@"superAccording"];
    [aCoder encodeObject:self.subAccordings forKey:@"subAccordings"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self.superAccording = [aDecoder decodeObjectForKey:@"superAccording"];
    self.subAccordings = [aDecoder decodeObjectForKey:@"subAccordings"];
    return self;
}

#pragma mark- 文件存储
// 文件存储方式
- (void)writeToFile:(NSString *)path atomically:(BOOL)atomic{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:path atomically:atomic];
}

// 转换成NSData
- (NSData *)data{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

// NSData转换成对象
+ (SGKAccordingRelation *)relationWithData:(NSData *)data{
    SGKAccordingRelation * relation = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return relation;
}

@end
