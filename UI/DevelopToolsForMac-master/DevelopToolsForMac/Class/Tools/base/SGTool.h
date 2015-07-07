//
//  SGTool.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^SetupBlock)();
typedef void(^ResultBlock)(id result);
@interface SGTool : NSObject

// 初始化方法
- (instancetype)initWithClassName:(NSString *)className;

// 添加block
- (void)setupBlock:(SetupBlock)setupBlock resultBlock:(ResultBlock)resultBlock;

#pragma mark - 公开对外的方法
- (void)startThread;
- (void)stopThread;

@end
