//
//  WPBatches.m
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBatches.h"
#import "WPBaseBatch.h"

@implementation WPBatches{
    WPBaseBatch * _baseBatch;
}

- (void)run:(NSString *)keyBatchClass{
    Class bClass = NSClassFromString(keyBatchClass);
    if (!bClass) {
        WpLog(@"未找到Batch文件");
        return;
    }
    _baseBatch = [[bClass alloc] init];
    // 执行条件
    [_baseBatch setUp];
    // 执行主体
    [_baseBatch excute];
    // 执行结果处理
    [_baseBatch tearDown];
}

@end
