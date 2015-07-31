//
//  SGKSocketSender.h
//  DemoStruts
//
//  Created by 丁治文 on 15/1/16.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

@protocol SGKSocketSenderDelegate <NSObject>



@end

@interface SGKSocketSender : NSObject<NSStreamDelegate>{
    /**
     *  操作标志 0为发送 1为接收
     */
    int _flag ;
    NSString * _filePath;
    NSString * _recivedPath;
    UInt8 * _sendBuff;
    NSData * _recivedData;
    CFStringRef _toHost;
    UInt32 _toPort;
}

@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;

@property (assign, nonatomic) id delegate;

+ (void)writeFileWithData:(NSData *)data path:(NSString *)path;

+ (NSData *)readDataWithFilePath:(NSString *)path;

- (id)initWithDelegate:(id<SGKSocketSenderDelegate>)delegate;

- (void)setHost:(NSString *)host port:(UInt32)port;

- (void)writeData:(NSData *)data;

- (void)readDataWithPath:(NSString *)path;

- (void)initNetworkCommunication;

- (void)close;

@end
