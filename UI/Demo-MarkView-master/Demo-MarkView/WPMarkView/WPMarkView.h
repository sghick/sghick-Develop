//
//  WPMarkView.h
//  WisdomPark
//
//  Created by 丁治文 on 15/4/16.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WPStringRect(x,y,w,h) (NSStringFromCGRect(CGRectMake(x, y, w, h)))

typedef enum {
    WPMarkShowStyleDefault = 0,
    WPMarkShowStyleHalf,
    WPMarkShowStyleWhole
}WPMarkShowStyle;

typedef enum {
    WPMarkDirectionHorizontal   = 1 << 0,
    WPMarkDirectionVertical     = 1 << 1,
    WPMarkDirectionALL          = WPMarkDirectionHorizontal|WPMarkDirectionVertical
}WPMarkDirection;

@class WPMarkView;
@protocol WPMarkViewDelegate <NSObject>

@optional
// 选择的分数
- (void)markView:(WPMarkView *)markView selectedScore:(CGFloat)score;

@end

@interface WPMarkView : UIView

// 前景图片
@property (strong, readonly, nonatomic) UIImage * image;
// 背景图片
@property (strong, readonly, nonatomic) UIImage * backImage;
// 指定图片的大小
@property (assign, nonatomic) CGRect imageBounds;


// mark的排列方向
@property (assign, nonatomic) WPMarkDirection markDirection;

// mark的总个数
@property (assign, readonly, nonatomic) NSInteger numberOfMarks;

// 显示mark的方式 暂时只支持WPMarkShowStyleWhole
@property (assign, nonatomic) WPMarkShowStyle markShowStyle;

// 是否自定义位置
@property (assign, nonatomic) BOOL isCustomSeat;

// 自定义的位置
@property (strong, nonatomic) NSArray * customFrames;

// 是否可选
@property (assign, nonatomic) BOOL isSelect;

// 值
@property (assign, nonatomic) CGFloat markValue;

// 代理
@property (assign, nonatomic) id<WPMarkViewDelegate> delegate;

// 设置图片
- (void)setImage:(UIImage *)image backImage:(UIImage *)backImage numberOfMarks:(NSInteger)numberOfMarks;
// 设置字符串
- (void)setString:(NSString *)string backString:(NSString *)backString attributes:(NSDictionary *)attributes;

// 设置偏移量和间隔
- (void)setOffsets:(NSArray *)offsets space:(CGFloat)space;

@end
