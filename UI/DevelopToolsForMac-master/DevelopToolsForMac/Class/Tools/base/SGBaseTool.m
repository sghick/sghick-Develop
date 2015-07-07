//
//  SGBaseTool.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGBaseTool.h"
@implementation SGBaseTool

#pragma mark - 要重写的方法/静态库应该提供此方法作为接口
- (void)execute:(id (^)())setup block:(void (^)(id))block{
    NSLog(@"子类应该重写此方法：SGBaseTool execute");
}


@end
