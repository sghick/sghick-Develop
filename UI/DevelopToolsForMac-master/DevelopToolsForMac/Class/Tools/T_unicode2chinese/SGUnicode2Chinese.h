//
//  SGUnicode2Chinese.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGBaseTool.h"

@interface SGUnicode2Chinese : SGBaseTool

- (void)execute:(id(^)())setup block:(void (^)(id result))block;

@end
