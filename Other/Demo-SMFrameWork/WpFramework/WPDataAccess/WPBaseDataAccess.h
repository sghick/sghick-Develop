//
//  WPBaseDataAccess.h
//  WisdomPark
//
//  Created by 丁治文 on 15/1/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstUrl.h"
#import "WPUrlRequest.h"

@interface WPBaseDataAccess : NSObject{
    // 委托
    id _delegate;
    // 请求完成时调用的方法(不使用协议的实现方式)
    SEL _finishedSelector;
    // 请求失败时调用的方法(不使用协议的实现方式)
    SEL _faildSelector;
}

/**
 *  初始化方法
 *
 *  @param delegate         代理
 *  @param finishedSelector 请求完成时调用的selector
 *  @param faildSelector    请求失败时调用的selector
 */
- (id)initWithDelegate:(id)delegate finishedSelector:(SEL)finishedSelector faildSelector:(SEL)faildSelector;


/**
 *  初始化方法
 *
 *  @param delegate         代理
 *  @param finishedSelector 请求完成时调用的selector
 *  @param faildSelector    请求失败时调用的selector
 */
- (void)setDelegate:(id)delegate finishedSelector:(SEL)finishedSelector faildSelector:(SEL)faildSelector;

/**
 *  返回一个初始化之后的请求
 *
 *  @return 一个初始化之后的请求
 */
- (WPUrlRequest *)wpUrlRequest;

@end
