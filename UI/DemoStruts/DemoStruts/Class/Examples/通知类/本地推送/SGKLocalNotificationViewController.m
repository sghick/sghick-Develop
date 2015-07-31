//
//  SGKLocalNotificationViewController.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/9.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKLocalNotificationViewController.h"
#import "SGKNotificaitonModel.h"

@interface SGKLocalNotificationViewController ()

@end

@implementation SGKLocalNotificationViewController

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
    
    UIButton * planNotiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [planNotiBtn setFrame:CGRectMake(110, 100, 100, 30)];
    [planNotiBtn setTitle:@"计划发送通知" forState:UIControlStateNormal];
    [planNotiBtn addTarget:self action:@selector(planNotiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:planNotiBtn];
    
    UIButton * planEndNotiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [planEndNotiBtn setFrame:CGRectMake(110, 140, 100, 30)];
    [planEndNotiBtn setTitle:@"结束发送通知" forState:UIControlStateNormal];
    [planEndNotiBtn addTarget:self action:@selector(planEndNotiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:planEndNotiBtn];
    
    UIButton * sendNotiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendNotiBtn setTitle:@"立即发送通知" forState:UIControlStateNormal];
    [sendNotiBtn addTarget:self action:@selector(sendNotiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendNotiBtn setFrame:CGRectMake(110, 180, 100, 30)];
    [self.view addSubview:sendNotiBtn];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)planNotiBtnAction:(UIButton *)btn{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //设置通知5秒后触发
    localNotification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:5];
    //设置通知消息
    localNotification.alertBody = @"计划通知，新年好!";
    SGKNotificaitonModel * noti = [[SGKNotificaitonModel alloc] init];
    noti.functionId = @"SGKLocalNotificationViewController";
    noti.content = @"计划通知，good new year!";
    localNotification.userInfo = noti.dictionary;
    //设置通知标记数
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    //设置通知出现时候声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //设置动作按钮的标题
    localNotification.alertAction = @"View Details";
    
    //计划通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)planEndNotiBtnAction:(UIButton *)btn{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)sendNotiBtnAction:(UIButton *)btn{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //设置通知消息
    localNotification.alertBody = @"立刻通知，新年好!";
    //设置通知徽章数
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    //设置通知出现时候声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //设置动作按钮的标题
    localNotification.alertAction = @"View Details";
    //立刻发通知
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}



@end
