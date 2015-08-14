//
//  JokeAPI.m
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "JokeAPI.h"
#import "SMUrlRequest.h"
#import "APIHeader.h"
#import "SMModel.h"

@implementation JokeAPI

- (SMUrlRequest *)requestJokeList {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_GET_TEST]];
    request.requestMethod = requestMethodGet;
    [request.parserMapper setObject:@"SMResult" forKey:parserReturnTypeMainModelOfKey];
    [request.parserMapper setObject:@"SMJoke" forKey:@"detail"];
    return request;
}

@end
