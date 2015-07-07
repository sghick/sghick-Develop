//
//  AnimationManager.m
//  Demo-SGKAnimation
//
//  Created by buding on 15/7/2.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "AnimationManager.h"

#define CHARS @[\
@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",\
@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",\
@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",\
@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",\
@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",\
@"Y",@"Z",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",\
@"8",@"9"\
]

@implementation AnimationManager

+ (instancetype)shareInstance {
    static AnimationManager *instance;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        instance = [[AnimationManager alloc] init];
    });
    return instance;
}

- (NSString *)startAnimation {
    self.animationState = AnimationStateValidate;
    NSString *serializationKey = [self serializationKey];
    return serializationKey;
}

- (void)cancelAnimation {
    self.animationState = AnimationStateCancel;
}

#pragma mark - ()
- (NSString *)serializationKey {
    NSMutableString *rtn = [NSMutableString stringWithCapacity:32];
    for (int i = 0; i < 32; i++) {
        int index = arc4random()%CHARS.count;
        [rtn appendFormat:@"%@", CHARS[index]];
    }
    NSLog(@"%@", rtn);
    return rtn;
}

@end
