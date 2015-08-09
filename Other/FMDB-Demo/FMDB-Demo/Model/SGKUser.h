//
//  SGKUser.h
//  FMDB-Demo
//
//  Created by qf on 14-10-31.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMModel.h"

@interface SGKUser : SMModel

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;

@end
