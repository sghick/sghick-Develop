//
//  SMJoke.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SMModel.h"

@interface SMJoke : SMModel

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *picUrl;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *xhid;

// DB
@property (assign, nonatomic) BOOL isRead;

@end
