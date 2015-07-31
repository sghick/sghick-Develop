//
//  WPUrlRequest+WP.h
//  WisdomPark
//
//  Created by 丁治文 on 15/2/12.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPUrlRequest.h"

@interface WPUrlRequest (WP)

/**
 *  开始请求
 */
- (void)startInQueue;

/**
 *  取消所有请求
 */
- (void)cancelAll;

@end
