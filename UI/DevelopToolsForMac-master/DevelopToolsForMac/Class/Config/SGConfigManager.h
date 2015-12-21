//
//  SGConfigManager.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPBaseModel.h"

@interface SGConfig : WPBaseModel

//@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) NSString * className;
@property (copy, nonatomic) NSString * helpMsg;
@property (copy, nonatomic) NSString * inputType;
@property (copy, nonatomic) NSString * outputType;
@property (copy, nonatomic) NSString * inputString;
@property (copy, nonatomic) NSString * outputString;

@end

@interface SGConfigManager : WPBaseModel

@property (copy, nonatomic) NSString * curItemName;
@property (strong, nonatomic) NSDictionary * configs;

+ (instancetype)defaultConfigManager;

/**
 *  保存配置
 */
- (void)save;

/**
 *  读取文件
 */
- (BOOL)readFile;

/**
 *  当前配置
 */
- (SGConfig *)curConfig;

@end
