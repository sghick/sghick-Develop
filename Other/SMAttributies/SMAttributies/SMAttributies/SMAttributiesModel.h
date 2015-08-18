//
//  SMAttributiesModel.h
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMPercentageFrame : NSObject

@property (strong, nonatomic) NSString *scale;          /*< 可空,宽高系数的比例,"-"表示自动,默认为"-,-" */
@property (strong, nonatomic) NSString *screenScale;    /*< 可空,view最宽值,默认为"-,-" */
@property (strong, nonatomic) NSString *maxWidth;       /*< 可空,view最宽值,默认为"-" */
@property (strong, nonatomic) NSString *maxHeight;      /*< 可空,view最高值,默认为"-" */
@property (strong, nonatomic) NSString *width;          /*< 可空,view的宽,默认为"-" */
@property (strong, nonatomic) NSString *height;         /*< 可空,view的高,默认为"-" */
@property (strong, nonatomic) NSString *margin;         /*< 可空,view四个方向的空白区,默认为"-,-,-,-" */

@end

@interface SMRealFrame : NSObject

@property (strong, nonatomic) NSString *width;          /*< 可空,view的宽,默认为"-" */
@property (strong, nonatomic) NSString *height;         /*< 可空,view的高,默认为"-" */
@property (strong, nonatomic) NSString *margin;         /*< 可空,view四个方向的空白区,默认为"-,-,-,-" */

@end
