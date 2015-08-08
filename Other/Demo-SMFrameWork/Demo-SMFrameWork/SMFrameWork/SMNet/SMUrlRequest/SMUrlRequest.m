//
//  SMUrlRequest.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMUrlRequest.h"
#import "SMModel.h"

@implementation SMUrlRequestParamFile

+ (instancetype)paramFileWithData:(NSData *)data paramName:(NSString *)paramName fileName:(NSString *)fileName mimeType:(NSString *)mimeType{
    SMUrlRequestParamFile * file = [[SMUrlRequestParamFile alloc] init];
    file.data = data;
    file.paramName = paramName;
    file.fileName = fileName;
    file.mimeType = mimeType;
    return file;
}

@end

// 作为userInfo的key
#define KEY_ASI_HTTP_REQUEST_KEY @"__KEY_ASI_HTTP_REQUEST_KEY__"

@implementation SMUrlRequest

#pragma mark - SMUrlRequest

- (id)init{
    self = [super init];
    if (self) {
        [self initRequestWithUrl:nil];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL {
    self = [super initWithURL:URL];
    if (self) {
        [self initRequestWithUrl:URL];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
    self = [super initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    if (self) {
        [self initRequestWithUrl:URL];
    }
    return self;
}

- (void)initRequestWithUrl:(NSURL *)URL {
    // 设置默认请求方法
    _requestMethod = requestMethodGet;
    // 初始化参数
    _paramsFiles = [[NSMutableArray alloc] initWithCapacity:0];
    _paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    _parserMapper = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (URL) {
        _urlString = URL.absoluteString;
    }
}

/**
 *  调用请求完成
 */
- (void)finished{
    if ([_delegate respondsToSelector:_finishedSelector]) {
        [_delegate performSelector:_finishedSelector withObject:self afterDelay:0.0f];
    }
}

/**
 *  调用请求失败
 */
- (void)faild{
    if ([_delegate respondsToSelector:_faildSelector]) {
        [_delegate performSelector:_faildSelector withObject:self afterDelay:0.0f];
    }
}

/**
 *  调试方法
 */
- (NSString *)description{
    return [NSString stringWithFormat:@"key:%@ url:%@", self.key, self.urlString];
}

- (NSData *)responseData{
    if (_responseData) {
        // 什么也不做
    } else if (_responseString){
        _responseData = [NSJSONSerialization dataWithJSONObject:_responseString options:NSJSONWritingPrettyPrinted error:nil];
    } else if (_responseDictionary) {
        _responseData = [NSJSONSerialization dataWithJSONObject:_responseDictionary options:NSJSONWritingPrettyPrinted error:nil];
    } else if (_responseObject) {
        if ([_responseObject isKindOfClass:[NSDictionary class]]) {
            _responseDictionary = _responseObject;
            _responseData = [self responseData];
        } else if ([_responseObject isKindOfClass:[NSData class]]){
            _responseData = _responseObject;
        } else {
            SMLog(@"%@:WPUrlRequest:从服务器中接收了不是NSData和NSDictionary对象以外的对象", kLogError);
            _responseData = nil;
        }
    }
    return _responseData;
}

- (NSString *)responseString{
    if (_responseString){
        // 什么也不做
    } else {
        _responseString = [NSString stringWithFormat:@"%@", self.responseDictionary];
    }
    return _responseString;
}

- (NSDictionary *)responseDictionary{
    if (_responseDictionary) {
        // 什么也不做
    } else {
        _responseDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:nil];
    }
    return _responseDictionary;
}

- (id)responseParserObject{
    if (_responseDictionary) {
        [self responseDictionary];
    }
    
    if (!self.parserMapper.count) {
        return self.responseString;
    }
    Class mainModelClass = NSClassFromString([self.parserMapper objectForKey:parserReturnTypeMainModelOfKey]);
    if (mainModelClass) {
        SMModel *model = [[mainModelClass alloc] init];
        NSMutableDictionary * newMapper = [NSMutableDictionary dictionaryWithDictionary:self.parserMapper];
        [newMapper removeObjectForKey:parserReturnTypeMainModelOfKey];
        [model setValuesWithDictionary:self.responseDictionary classNamesMapper:newMapper];
        _responseParserObject = model;
    } else{
        _responseParserObject = [SMModel arrayWithDictionary:self.responseDictionary classNamesMapper:self.parserMapper];
    }
    return _responseParserObject;
}

- (void)clearResponse {
    _responseData = nil;
    _responseDictionary = nil;
    _responseErrorCode = nil;
    _responseErrorMsg = nil;
    _responseObject = nil;
    _responseString = nil;
    _responseParserObject = nil;
}

@end
