//
//  NSUserDefaults+SMModel.h
//  Hahaha
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMModel;
@interface NSUserDefaults (SMModel)

- (void)setModel:(SMModel *)model forKey:(NSString *)key;
- (id)modelForKey:(NSString *)key;

@end

