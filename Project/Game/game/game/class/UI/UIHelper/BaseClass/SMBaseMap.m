//
//  SMBaseMap.m
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "SMBaseMap.h"

@implementation SMBaseMap

+ (instancetype)map {
    SMBaseMap *map = [[SMBaseMap alloc] initWithFrame:SMScreenBounds];
    
    map.userInteractionEnabled = NO;
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
