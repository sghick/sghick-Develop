//
//  SGKSocketSenderViewController.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/16.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#define TO_HOST @"192.168.1.189"
#define TO_PORT 7878
#define FILE_PATH @""

#import "SGKSocketSenderViewController.h"
#import "SGKSocketSender.h"

@interface SGKSocketSenderViewController ()<SGKSocketSenderDelegate>

@end

@implementation SGKSocketSenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton * btnSend = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnSend setFrame:CGRectMake(40, 80, 100, 40)];
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSend];
    
    UIButton * btnRecive = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnRecive setFrame:CGRectMake(150, 80, 100, 40)];
    [btnRecive setTitle:@"接收" forState:UIControlStateNormal];
    [btnRecive addTarget:self action:@selector(receiveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRecive];
    
    // 创建客户端
    _client = [[SGKSocketSender alloc] initWithDelegate:self];
    [_client setHost:TO_HOST port:TO_PORT];

}

/**
 *  发送文件
 */
- (void)sendAction:(UIButton *)btn{
    NSData * data = [SGKSocketSender readDataWithFilePath:FILE_PATH];
    [_client writeData:data];
}

/**
 *  接收文件
 */
- (void)receiveAction:(UIButton *)btn{
    
}

@end
