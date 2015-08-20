//
//  WPBaseDalFactory.h
//  WisdomPark
//
//  Created by 丁治文 on 15/3/5.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPBaseDalFactory : NSObject{
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


@end
