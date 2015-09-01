//
//  ViewController.m
//  upyun-demo
//
//  Created by 丁治文 on 15/9/2.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NSString+MD5Addition.h"
#import "NSData+MD5Digest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 80, 50);
    btn.center = self.view.center;
    [btn setTitle:@"上传图片" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(uploadPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)uploadPic:(UIButton *)sender {
    NSString *buket = @"sghickios";
    NSString *url = [@"http://v0.api.upyun.com/" stringByAppendingString:buket];
    NSString *operator = @"ios";
    NSString *password = @"ios123456";
    NSString *method = @"POST";
    NSString *path = @"";
    
    UIImage *image = [UIImage imageNamed:@"lpz002"];
    NSDate *date = [NSDate date];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSString *signStr = [self sign:method :path :date :imageData.length :password];
    NSString *signature = [NSString stringWithFormat:@"UpYun %@:%@", operator, signStr];
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Authorization"];
    NSLog(@"header:%@", manager.requestSerializer.HTTPRequestHeaders);
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.jpg" mimeType:@"multipart/form-data"];
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"文件上传成功");
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"文件上传失败: %@", error);
    }];

    
}

- (NSString *)sign:(NSString *)method :(NSString *)path :(NSDate *)date :(long)contentLenght :(NSString *)password {
    NSString *rtn = [NSString stringWithFormat:@"%@&%@&%@&%@&%@&",
                     method,
                     path,
                     date,
                     [NSString stringWithFormat:@"%ld", contentLenght],
                     password.stringFromMD5];
    rtn = [[rtn dataUsingEncoding:NSUTF8StringEncoding] MD5HexDigest];
    return rtn;
}

-(NSString * )getSaveKey {
    NSDate *d = [NSDate date];
    return [NSString stringWithFormat:@"/%zi/%zi/%.0f.jpg",[self getYear:d],[self getMonth:d],[[NSDate date] timeIntervalSince1970]];
}
- (NSInteger)getYear:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger year = [comps year];
    return year;
}
- (NSInteger)getMonth:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger month = [comps month];
    return month;
}

@end
