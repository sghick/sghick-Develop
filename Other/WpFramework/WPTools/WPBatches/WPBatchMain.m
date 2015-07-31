//
//  WPBatchMain.m
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBatchMain.h"
#import "WPBatches.h"

@implementation WPBatchMain

- (void)run{
    WPBatches * batch = [[WPBatches alloc] init];
    [batch run:kbcModelCreate];
}

@end
