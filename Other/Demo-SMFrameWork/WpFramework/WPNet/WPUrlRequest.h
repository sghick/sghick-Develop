//
//  WPUrlRequest.h
//  WisdomPark
//
//  Created by 丁治文 on 15/1/24.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WPUrlRequestParamFile : NSObject

@property (strong, nonatomic) NSData * data;
@property (strong, nonatomic) NSString * paramName;
@property (strong, nonatomic) NSString * fileName;
@property (strong, nonatomic) NSString * mimeType;

+ (instancetype)paramFileWithData:(NSData *)data paramName:(NSString *)paramName fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end

// 请求方法
static NSString * requestMethodGet = @"GET";
static NSString * requestMethodPost = @"POST";
static NSString * requestMethodFile = @"FILE";

@interface WPUrlRequest : NSObject

// 委托
@property (assign, nonatomic) id delegate;
// 完成时调用的方法(不使用协议的实现方式)
@property (assign, nonatomic) SEL finishedSelector;
@property (assign, nonatomic) SEL faildSelector;
// 唯一标识
@property (copy, nonatomic) NSString * key;
// 请求方式,默认为requestMethodGet
@property (copy, nonatomic) NSString * requestMethod;
// urlString
@property (copy, nonatomic) NSString * urlString;
// 文件-二进制格式 WPUrlRequestParamFile
@property (strong, nonatomic) NSMutableArray * paramsFiles;
// 请求参数-POST/FILE请求用
@property (strong, nonatomic) NSMutableDictionary * paramsDict;
// 解析数据类映射
@property (strong, nonatomic) NSMutableDictionary * parserMapper;

// 用于保存错误信息
@property (strong, nonatomic) NSString * responseErrorCode;
@property (strong, nonatomic) NSString * responseErrorMsg;
// 用于保存请求到的数据
@property (strong, nonatomic) id responseObject;
// 用于保存请求到的数据
@property (strong, nonatomic) NSData * responseData;
// 用于保存请求到的数据
@property (copy, nonatomic) NSString * responseString;
// 用于保存请求到的数据
@property (copy, nonatomic) NSDictionary * responseDictionary;
// 用于保存请求到的数据 需要设置parser
@property (strong, nonatomic) id responseParserObject;

#pragma mark - SpUrlRequest
// 清楚结果
- (void)clearResponse;
// 调用请求完成
- (void)finished;
// 调用请求失败
- (void)faild;

@end
