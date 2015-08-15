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

- (SMUrlRequest *)requestJokeList1 {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_JOKE_LIST1]];
    request.requestMethod = requestMethodGet;
    [request.parserMapper setObject:@"SMResult" forKey:parserReturnTypeMainModelOfKey];
    [request.parserMapper setObject:@"SMJoke" forKey:@"detail"];
    [request.parserKeysMapper setObject:@"uid" forKey:@"id"];
    [request.parserKeysMapper setObject:@"title" forKey:@"author"];
    return request;
}

- (SMUrlRequest *)requestJokeList2 {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_JOKE_LIST2]];
    request.requestMethod = requestMethodGet;
    [request.parserMapper setObject:@"SMJoke" forKey:parserReturnTypeMainArrayOfKey];
    return request;
}

- (SMUrlRequest *)requestJokeList3 {
    SMUrlRequest *request = [self smUrlRequestWithUrl:[NSURL URLWithString:URL_JOKE_LIST3]];
    request.requestMethod = requestMethodGet;
    [request.parserMapper setObject:@"SMResult" forKey:parserReturnTypeMainModelOfKey];
    [request.parserMapper setObject:@"SMJoke" forKey:@"detail"];
    [request.parserKeysMapper setObject:@"uid" forKey:@"id"];
    [request.parserKeysMapper setObject:@"title" forKey:@"author"];
    return request;
}

@end
