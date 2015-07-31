//
//  WPBaseBatch.m
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPBaseBatch.h"

@implementation WPBaseBatch

@synthesize inputFilePath = _inputFilePath;
@synthesize outputFilePath = _outputFilePath;
@synthesize inputDirectoryPath = _inputDirectoryPath;
@synthesize outputDirectoryPath = _outputDirectoryPath;

- (NSString *)inputFilePath{
    if (_inputFilePath) {
        return _inputFilePath;
    }
    if (_inputPath) {
        _inputFilePath = _inputPath;
        return _inputFilePath;
    }
    WpLog(@"未设置输入文件路径");
    return nil;
}

- (NSString *)outputFilePath{
    if (_outputFilePath) {
        return _outputFilePath;
    }
    if (_outputPath) {
        _outputFilePath = _outputPath;
        return _outputFilePath;
    }
    WpLog(@"未设置输出文件路径");
    return nil;
}

- (NSString *)inputDirectoryPath{
    if (_inputDirectoryPath) {
        return _inputDirectoryPath;
    }
    if (self.inputPath) {
        if ([self.inputPath hasSuffix:@".txt"]) {
            return [self.inputPath stringByDeletingLastPathComponent];
        }
        return self.inputPath;
    }
    WpLog(@"未设置输入文件夹路径");
    return nil;
}

- (NSString *)outputDirectoryPath{
    if (_outputDirectoryPath) {
        return _outputDirectoryPath;
    }
    if (self.outputPath) {
        if ([self.outputPath hasSuffix:@".txt"]) {
            return [self.outputPath stringByDeletingLastPathComponent];
        }
        return self.outputPath;
    }
    WpLog(@"未设置输出文件夹路径");
    return nil;
}

#pragma mark - WPBatchProtocol

- (void)setUp{
    
}

- (void)excute{
    
}

- (void)tearDown{
    
}

@end
