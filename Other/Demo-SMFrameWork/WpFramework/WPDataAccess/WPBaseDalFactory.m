//
//  WPBaseDalFactory.m
//  WisdomPark
//
//  Created by 丁治文 on 15/3/5.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBaseDalFactory.h"

@implementation WPBaseDalFactory

/**
 *  初始化方法
 *
 *  @param delegate         代理
 *  @param finishedSelector 请求完成时调用的selector
 *  @param faildSelector    请求失败时调用的selector
 */
- (id)initWithDelegate:(id)delegate finishedSelector:(SEL)finishedSelector faildSelector:(SEL)faildSelector{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _finishedSelector = finishedSelector;
        _faildSelector = faildSelector;
    }
    return self;
}

@end
