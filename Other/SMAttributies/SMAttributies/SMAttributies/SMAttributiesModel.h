//
//  SMAttributiesModel.h
//  SMAttributies
//
//  Created by 丁治文 on 15/8/19.
//  Copyright © 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 解析文件用
@interface SMPercentageFrame : NSObject
@property (strong, nonatomic) NSString *userFrame;      /*< 可空,默认为"-" */
@property (strong, nonatomic) NSString *screenScale;    /*< 可空,父视图宽高比例划分,默认为"-,-" */
@property (strong, nonatomic) NSString *scale;          /*< 可空,宽高系数的比例,"-"表示自动,默认为"-,-" */
@property (strong, nonatomic) NSString *size;           /*< 可空,view的size,默认为"-,-" */
@property (strong, nonatomic) NSString *insets;         /*< 可空,view四个方向的空白区,默认为"-,-,-,-" */
@end

//@interface SMRealFrame : NSObject
//@property (strong, nonatomic) NSString *scale;          /*< 可空,宽高系数的比例,"-"表示自动,默认为"-,-" */
//@property (strong, nonatomic) NSString *size;           /*< 可空,view的size,默认为"-,-" */
//@property (strong, nonatomic) NSString *insets;         /*< 可空,view四个方向的空白区,默认为"-,-,-,-" */
//@end

#pragma mark - 计算布局用
@interface SMTransPercentageFrame : NSObject
// userFrame
@property (assign, nonatomic) BOOL  userFrame;
// screenScale
@property (assign, nonatomic) float screenScaleX;
@property (assign, nonatomic) BOOL  isAutoScreenScaleX;
@property (assign, nonatomic) float screenScaleY;
@property (assign, nonatomic) BOOL  isAutoScreenScaleY;
// scale
@property (assign, nonatomic) float scaleX;
@property (assign, nonatomic) BOOL  isAutoScaleX;
@property (assign, nonatomic) float scaleY;
@property (assign, nonatomic) BOOL  isAutoScaleY;
// size
@property (assign, nonatomic) float width;
@property (assign, nonatomic) BOOL  isAutoWidth;
@property (assign, nonatomic) float height;
@property (assign, nonatomic) BOOL  isAutoHeight;
// insets
@property (assign, nonatomic) float insetsTop;
@property (assign, nonatomic) BOOL  isAutoInsetsTop;
@property (assign, nonatomic) float insetsLeft;
@property (assign, nonatomic) BOOL  isAutoInsetsLeft;
@property (assign, nonatomic) float insetsBottom;
@property (assign, nonatomic) BOOL  isAutoInsetsBottom;
@property (assign, nonatomic) float insetsRight;
@property (assign, nonatomic) BOOL  isAutoInsetsRight;
// 错误信息
@property (strong, nonatomic) NSArray *errors;
+ (SMTransPercentageFrame *)transWithPercentageFrame:(SMPercentageFrame *)percentageFrame pathKey:(NSString *)pathKey;
@end

//@interface SMTransRealFrame : NSObject
//// scale
//@property (assign, nonatomic) float scaleX;
//@property (assign, nonatomic) BOOL  isAutoScaleX;
//@property (assign, nonatomic) float scaleY;
//@property (assign, nonatomic) BOOL  isAutoScaleY;
//// size
//@property (assign, nonatomic) float width;
//@property (assign, nonatomic) BOOL  isAutoWidth;
//@property (assign, nonatomic) float height;
//@property (assign, nonatomic) BOOL  isAutoHeight;
//// insets
//@property (assign, nonatomic) float insetsTop;
//@property (assign, nonatomic) BOOL  isAutoInsetsTop;
//@property (assign, nonatomic) float insetsLeft;
//@property (assign, nonatomic) BOOL  isAutoInsetsLeft;
//@property (assign, nonatomic) float insetsBottom;
//@property (assign, nonatomic) BOOL  isAutoInsetsBottom;
//@property (assign, nonatomic) float insetsRight;
//@property (assign, nonatomic) BOOL  isAutoInsetsRight;
//// 错误信息
//@property (strong, nonatomic) NSArray *errors;
//+ (SMTransRealFrame *)transWithRealFrame:(SMRealFrame *)realFrame pathKey:(NSString *)pathKey;
//@end


