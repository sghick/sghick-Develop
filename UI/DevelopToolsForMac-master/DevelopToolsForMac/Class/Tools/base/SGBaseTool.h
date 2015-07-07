//
//  SGBaseTool.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SGBaseTool : NSObject

#pragma mark - 要重写的方法
- (void)execute:(id(^)())setup block:(void (^)(id result))block;

@end
