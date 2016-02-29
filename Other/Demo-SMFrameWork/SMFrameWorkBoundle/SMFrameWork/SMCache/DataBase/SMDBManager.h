//
//  SMDBManager.h
//  Hahaha
//
//  Created by buding on 15/9/17.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMDBHelper;
@interface SMDBManager : NSObject

+ (SMDBHelper *)dbHelperWithDBPath:(NSString *)DBPath;
+ (instancetype)shareInstance;

@end
