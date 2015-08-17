//
//  SMAPI.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMAPI.h"
#import "SMUrlRequest.h"

@implementation SMAPI

- (id)initWithDelegate:(id)delegate finishedSelector:(SEL)finishedSelector faildSelector:(SEL)faildSelector{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _finishedSelector = finishedSelector;
        _faildSelector = faildSelector;
    }
    return self;
}

- (void)setDelegate:(id)delegate finishedSelector:(SEL)finishedSelector faildSelector:(SEL)faildSelector{
    _delegate = delegate;
    _finishedSelector = finishedSelector;
    _faildSelector = faildSelector;
}

- (SMUrlRequest *)smUrlRequestWithUrl:(NSURL *)url {
    SMUrlRequest * request = [[SMUrlRequest alloc] initWithURL:url];
    request.delegate = _delegate;
    request.finishedSelector = _finishedSelector;
    request.faildSelector = _faildSelector;
    return request;
}

@end
