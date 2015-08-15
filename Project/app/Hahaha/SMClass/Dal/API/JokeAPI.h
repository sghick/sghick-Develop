//
//  JokeAPI.h
//  Hahaha
//
//  Created by 丁治文 on 15/8/14.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMAPI.h"

@class SMModel;
@interface JokeAPI : SMAPI

- (SMUrlRequest *)requestJokeList1;
- (SMUrlRequest *)requestJokeList2;
- (SMUrlRequest *)requestJokeList3;

@end
