//
//  UIView+SMAttributies.m
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

// 分隔符
#define cPartString @","
// 自动符
#define cAutoString @"-"
// 使用比例宽,使用scale中的值
#define cSX         @"sx"
// 使用比例高,使用scale中的值
#define cSY         @"sy"

#import "UIView+SMAttributies.h"
#import "SMAttributiesModel.h"

@implementation UIView (SMAttributies)

- (void)displayWithAttributiesKey:(NSString *)key {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"ViewController" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *subDict = dict[key];
    
    // 设置view的属性
    NSDictionary *attributies = subDict[@"attributies"];
    if (attributies) {
        [self setValuesForKeysWithDictionary:attributies];
    }
    
    
    
    // 设置view的约束
    SMPercentageFrame *percentageFrame = subDict[@"percentageFrame"];
    if (percentageFrame) {
        
    } else {
        // 设置view的实际frame,设置了约束,frame自动失效
        SMRealFrame *realFrame = subDict[@"realFrame"];
    }
}

@end
