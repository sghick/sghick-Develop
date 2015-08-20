//
//  WPBatchProtocol.h
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WPBatchProtocol <NSObject>

// 初始化条件
- (void)setUp;

// 执行体
- (void)excute;

// 结果处理
- (void)tearDown;

@end
