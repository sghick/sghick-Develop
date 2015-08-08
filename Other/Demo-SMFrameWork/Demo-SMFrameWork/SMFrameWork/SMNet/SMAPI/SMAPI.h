//
//  SMAPI.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SMUrlRequest;
@interface SMAPI : NSObject

@property (assign, nonatomic) id delegate;              /*< 委托 */
@property (assign, nonatomic) SEL finishedSelector;     /*< 请求完成时调用的方法(不使用协议的实现方式) */
@property (assign, nonatomic) SEL faildSelector;        /*< 请求失败时调用的方法(不使用协议的实现方式) */

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
 *  @param url              可空
 */
- (SMUrlRequest *)smUrlRequestWithUrl:(NSURL *)url ;

@end
