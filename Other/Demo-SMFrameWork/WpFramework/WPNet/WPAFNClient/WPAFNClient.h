//
//  WPAFNClient.h
//  WisdomPark
//
//  Created by 丁治文 on 15/1/26.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#define URL_BASE __WP_BASEURL_

#import "AFHTTPRequestOperationManager.h"

@interface WPAFNClient : AFHTTPRequestOperationManager

@property (assign, nonatomic) AFNetworkReachabilityStatus status;

+ (instancetype)sharedClient;

@end
