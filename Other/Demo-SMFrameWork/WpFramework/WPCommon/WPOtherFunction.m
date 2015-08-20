//
//  WPOtherFunction.m
//  WisdomPark
//
//  Created by 丁治文 on 15/4/24.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPOtherFunction.h"

// 判断是否为闰年
bool wp_isLeapYear(long year){
    if (year%100 == 0) {
        return false;
    }
    if (year%4 != 0) {
        return false;
    }
    return true;
}
