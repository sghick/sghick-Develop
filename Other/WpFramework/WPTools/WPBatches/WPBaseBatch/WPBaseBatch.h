//
//  WPBaseBatch.h
//  WisdomPark
//
//  Created by 丁治文 on 15/2/6.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPBatchProtocol.h"

@interface WPBaseBatch : NSObject<WPBatchProtocol>

@property (copy, nonatomic) NSString * inputPath;
@property (copy, nonatomic) NSString * outputPath;

@property (copy, nonatomic, readonly) NSString * inputFilePath;
@property (copy, nonatomic, readonly) NSString * outputFilePath;

@property (copy, nonatomic, readonly) NSString * inputDirectoryPath;
@property (copy, nonatomic, readonly) NSString * outputDirectoryPath;

@end
