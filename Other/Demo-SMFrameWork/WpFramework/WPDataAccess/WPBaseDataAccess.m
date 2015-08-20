//
//  WPBaseDataAccess.m
//  WisdomPark
//
//  Created by 丁治文 on 15/1/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBaseDataAccess.h"

@implementation WPBaseDataAccess

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

/**
 *  初始化方法
 *
 *  @param delegate         代理
 *  @param finishedSelector 请求完成时调用的selector
 *  @param faildSelector    请求失败时调用的selector
 */
- (void)setDelegate:(id)delegate finishedSelector:(SEL)finishedSelector faildSelector:(SEL)faildSelector{
    _delegate = delegate;
    _finishedSelector = finishedSelector;
    _faildSelector = faildSelector;
}

/**
 *  返回一个初始化之后的请求
 *
 *  @return 一个初始化之后的请求
 */
- (WPUrlRequest *)wpUrlRequest{
    WPUrlRequest * request = [[WPUrlRequest alloc] init];
    request.delegate = _delegate;
    request.finishedSelector = _finishedSelector;
    request.faildSelector = _faildSelector;
    return request;
}

@end
