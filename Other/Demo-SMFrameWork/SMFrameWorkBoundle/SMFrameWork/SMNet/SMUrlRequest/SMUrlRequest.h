//
//  SMUrlRequest.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMModel.h"

@interface SMUrlRequestParamFile : NSObject

@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSString *paramName;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *mimeType;

+ (instancetype)paramFileWithData:(NSData *)data paramName:(NSString *)paramName fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end

// 请求方法
static NSString *requestMethodGet   = @"GET";
static NSString *requestMethodPost  = @"POST";
static NSString *requestMethodFile  = @"FILE";
static NSString *requestMethodLocal = @"LOCAL";

@interface SMUrlRequest : NSURLRequest

@property (assign, nonatomic) id delegate;                              /*< 请求完成后 要调用的委托对象 */
@property (assign, nonatomic) SEL finishedSelector;                     /*< 请求成功时 完成时调用的方法(不使用协议的实现方式) */
@property (assign, nonatomic) SEL faildSelector;                        /*< 请求失败时 要调用的方法 */
@property (strong, nonatomic) NSString *key;                            /*< 和page作为唯一标识 */
@property (assign, nonatomic) int page;                                 /*< 和key作为唯一标识 */
@property (strong, nonatomic) NSString *requestMethod;                  /*< 请求方式,默认为requestMethodGet */
@property (strong, nonatomic) NSString *requestLocalPathExtension;      /*< 请求方式为requestMethodLocal,文件的扩展名,默认为json */
@property (strong, readonly, nonatomic) NSString *urlString;            /*< 设置此属性会同时给父类的URL属性赋值，包括schem */
@property (strong, nonatomic) NSMutableArray *paramsFiles;              /*< 文件-二进制格式 WPUrlRequestParamFile */
@property (strong, nonatomic) NSMutableDictionary *paramsDict;          /*< 请求参数-POST/FILE请求用 请求用到的参数列表 字典 */
@property (strong, nonatomic) NSMutableDictionary *parserMapper;        /*< 解析数据映射  响应用到的字典 */
@property (strong, nonatomic) NSMutableDictionary *parserKeysMapper;    /*< 解析数据映射  响应用到的字典 */

// 返回结果
@property (strong, nonatomic) NSString *responseErrorCode;          /*< 用于保存错误信息 */
@property (strong, nonatomic) NSString *responseErrorMsg;           /*< 用于保存错误信息 */
@property (strong, nonatomic) id responseObject;                    /*< 用于保存请求到的数据 */
@property (strong, nonatomic) NSData *responseData;                 /*< 用于保存请求到的数据 */
@property (strong, nonatomic) NSString *responseString;             /*< 用于保存请求到的数据 */
@property (strong, nonatomic) NSDictionary *responseDictionary;     /*< 用于保存请求到的数据 */
@property (strong, nonatomic) id responseParserObject;              /*< 用于保存请求到的数据 需要设置parser */

// 缓存
@property (strong, nonatomic) NSString *cachefileDoc;               /*< 自动缓存的缓存目录，默认 ~/Document/SMRequestCache/ */
@property (assign, nonatomic) BOOL useCache;                        /*< 自动缓存 自动缓存期限，0为无期限*/
@property (assign, nonatomic) NSTimeInterval cacheTimeOut;          /*< 自动缓存期限，0为无期限 */
@property (strong, nonatomic) id responseParserCacheObject;         /*< 用于保存请求到的数据 需要设置parser */

// 队列
@property (assign, nonatomic) NSInteger requestCount;               /*< 用于在队列中请求的次数累计 */

#pragma mark - SMUrlRequest

- (void)clearResponse;  /*< 清除上一次请求的响应结果 */
- (void)finished;       /*< 请求成功后，调用的方法，该方法会调用 delegate 的 _finishedSelector 方法 */
- (void)faild;          /*< 请求失败后，调用的方法，该方法会调用 delegate 的 _faildSelector 方法 */

// 缓存
- (void)clearCache;     /*< 清除本请求的缓存 */
+ (void)clearAllCache;  /*< 清除所有请求的缓存 */

@end
