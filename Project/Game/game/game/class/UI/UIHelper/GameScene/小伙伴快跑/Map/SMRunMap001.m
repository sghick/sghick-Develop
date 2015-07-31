//
//  SMRunMap001.m
//  game
//
//  Created by 丁治文 on 15/7/18.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMRunMap001.h"

@implementation SMRunMap001

+ (instancetype)map {
    SMRunMap001 *map = [super map];
    map.contentSize = CGSizeMake(10000*SMScreenWidth, SMScreenHeight);
    map.contentOffset = CGPointZero;
    for (int i = 0; i < 50; i++) {
        UIImageView *loadingImageView = [[UIImageView alloc] init];
        loadingImageView.image = [UIImage imageNamed:@"loading_叮当猫"];
        loadingImageView.frame = CGRectMake(SMScreenWidth*i, 0, SMScreenWidth, SMScreenHeight);
        [map addSubview:loadingImageView];
    }
    return map;
}

@end
