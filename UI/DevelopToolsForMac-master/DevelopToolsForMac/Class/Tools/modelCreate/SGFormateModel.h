//
//  SGFormateModel.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/10.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGBaseTool.h"

@interface SGFormateModel : SGBaseTool

- (void)execute:(id (^)())setup block:(void (^)(id))block;

@end
