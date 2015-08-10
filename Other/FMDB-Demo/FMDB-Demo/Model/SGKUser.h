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

@property (assign, nonatomic) NSInteger uid;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (strong, nonatomic) NSMutableString *mstr;
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) NSMutableDictionary *mdict;
@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL BL;
@property (assign, nonatomic) bool bbl;
@property (assign, nonatomic) NSNumber *num;

@end
