//
//  SGTool.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGTool.h"
#import "SGBaseTool.h"

@implementation SGTool{
    NSThread * _task;
    SGBaseTool * _baseTool;
    SetupBlock _setupBlock;
    ResultBlock _resultBlock;
}

- (instancetype)initWithClassName:(NSString *)className{
    self = [super init];
    if (self) {
        Class toolClass = NSClassFromString(className);
        _baseTool = [[toolClass alloc] init];
    }
    return self;
}

- (void)setupBlock:(SetupBlock)setupBlock resultBlock:(ResultBlock)resultBlock{
    _setupBlock = setupBlock;
    _resultBlock = resultBlock;
}

#pragma mark - 线程处理
- (void)begin{
    [_baseTool execute:self.setupBlock block:self.resultBlock];
}

- (void)end:(id)obj{
    _resultBlock(obj);
}

#pragma mark - block
- (SetupBlock)setupBlock{
    NSLog(@"开始执行...");
    return _setupBlock;
}

- (ResultBlock)resultBlock{
    ResultBlock rtnBlock = ^(id result){
        [self endThread:result];
        NSLog(@"执行完成...");
    };
    return rtnBlock;
}

#pragma mark - 公开对外的方法
- (void)startThread{
    if (!_baseTool) {
        return;
    }
    if (!_task) {
        _task = [[NSThread alloc] initWithTarget:self selector:@selector(begin) object:nil];
    }
    [_task start];
}

- (void)stopThread{
    [_task cancel];
    NSLog(@"执行终止...");
}

- (void)endThread:(id)result{
    [self performSelectorOnMainThread:@selector(end:) withObject:result waitUntilDone:NO];
}

@end
