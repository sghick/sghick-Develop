//
//  SGKSocketSender.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/16.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKSocketSender.h"

@implementation SGKSocketSender

- (id)initWithDelegate:(id<SGKSocketSenderDelegate>)delegate{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)setHost:(NSString *)host port:(UInt32)port{
    _toHost = (__bridge CFStringRef)host;
    _toPort = port;
}

/**
 *  发送文件
 */
- (void)writeData:(NSData *)data{
    _flag = 0;
    _sendBuff = (UInt8 *)[data bytes];
    [self initNetworkCommunication];
}

/**
 *  接收文件
 */
- (void)readDataWithPath:(NSString *)path{
    _flag = 1;
    _recivedPath = path;
    [self initNetworkCommunication];
}

/**
 *  保存文件
 *
 */
+ (void)writeFileWithData:(NSData *)data path:(NSString *)path{
    
}

/**
 *  把文件转成data，并按相应的规则组织文件信息头
 *
 *  @param path 要发送的文件
 *
 */
+ (NSData *)readDataWithFilePath:(NSString *)path{
    // 文件的二进制数据
    NSData * fileData = [NSData dataWithContentsOfFile:path];
    // 拼接信息头
    NSString * headerString = [NSString stringWithFormat:@"Content-Length=%d;filename=%@;sourceid=%@\n", fileData.length, [path lastPathComponent], nil];
    NSData * headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
    // 拼全部信息
    NSMutableData * allData = [NSMutableData dataWithLength:50];
    [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
    [allData appendData:fileData];
    return allData;
}

- (void)initNetworkCommunication
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, _toHost, _toPort, &readStream, &writeStream);
    
    // CFStream对象转换成NSStream对象 无开销连接
    _inputStream = (__bridge_transfer NSInputStream *)readStream;
    _outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    
    // 设置self为委托协议NSStreamDelegate实现对象
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    // 设置Run Loop,它与函数 CFReadStreamScheduleWithRunLoop和CFWtritesStreamSchedulWithRunLoop作用是一样的。
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    // 打开流对象，与函数CFReadStreamOpen和CFWritesStreamOpen作用是一样的
	[_inputStream open];
    [_outputStream open];
    
}

- (void)close
{
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream setDelegate:nil];
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream setDelegate:nil];
}

#pragma mark - NSStreamDelegate协议中的方法
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSString *event;
    switch (streamEvent) {
            // 没有事件发生
        case NSStreamEventNone:
            event = @"NSStreamEventNone";
            break;
            // 成功打开流
        case NSStreamEventOpenCompleted:
            event = @"NSStreamEventOpenCompleted";
            break;
            // 这个流有数据可以读，在读取数据时使用
        case NSStreamEventHasBytesAvailable:
            event = @"NSStreamEventHasBytesAvailable";
            if (_flag == 1 && theStream == _inputStream && _recivedPath) {
                NSMutableData *input = [[NSMutableData alloc] init];
                // 为读取数据准备缓冲区
                uint8_t buffer[1024];
                int len;
                // 使用hasBytesAvailable判断是否流有数据可以读，如果有可读数据就进行循环读取。
                while([_inputStream hasBytesAvailable]){
                    // 读取数据到缓冲区，第一个参数是缓冲区对象buffer，第二个参数是读取缓冲区的字节长度
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0)
                    {
                        [input appendBytes:buffer length:len];
                    }
                }
                // 保存文件
                [SGKSocketSender writeFileWithData:input path:_recivedPath];
            }
            break;
            // 这个事件可以接收数据的写入，在写数据时使用
        case NSStreamEventHasSpaceAvailable:
            event = @"NSStreamEventHasSpaceAvailable";
            if (_flag == 0 && theStream == _outputStream && _sendBuff) {
                // 输出
                UInt8 * buff = _sendBuff;
                [_outputStream write:buff maxLength: strlen((const char*)buff)+1];
                // 必须关闭输出流否则，服务器端一直读取不会停止，
                [_outputStream close];
            }
            break;
            // 流发生错误
        case NSStreamEventErrorOccurred:
            event = @"NSStreamEventErrorOccurred";
            [self close];
            break;
            // 流结束
        case NSStreamEventEndEncountered:
            event = @"NSStreamEventEndEncountered";
            NSLog(@"Error:%d:%@",[[theStream streamError] code], [[theStream streamError] localizedDescription]);
            break;
        default:
            [self close];
            event = @"Unknown";
            break;
    }
    NSLog(@"event------%@",event);
}

@end
