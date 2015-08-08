//
//  SampleAPI.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SampleAPI.h"
#import "SMUrlRequest.h"
#import "APIHeader.h"
#import "SMModel.h"

@implementation SampleAPI

- (SMUrlRequest *)requestGetTestWithParam:(SMModel *)param {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_GET_TEST]];
    request.requestMethod = requestMethodGet;
    return request;
}

- (SMUrlRequest *)requestPostTestWithParam:(SMModel *)param {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_POST_TEST]];
    request.requestMethod = requestMethodPost;
    return request;
}

- (SMUrlRequest *)requestFILETestWithParam:(SMModel *)param {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_FILE_TEST]];
    request.requestMethod = requestMethodFile;
    return request;
}

@end
