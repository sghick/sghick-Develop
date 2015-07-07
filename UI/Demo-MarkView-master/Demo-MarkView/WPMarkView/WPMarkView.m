//
//  WPMarkView.m
//  WisdomPark
//
//  Created by 丁治文 on 15/4/16.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPMarkView.h"

#define DefaultFontSize 15
#define contentWidth(margin,space,width,index) (margin + space + (width + space)*index)

@implementation WPMarkView{
    NSArray * _offsets;
    CGFloat _space;
    
    CGRect _bounds;
    CGPoint _spacePoint;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setBackgroundColor:[UIColor clearColor]];
    _markDirection = WPMarkDirectionHorizontal;
    _space = -1;
}

#pragma mark - ()
- (void)setImage:(UIImage *)image backImage:(UIImage *)backImage numberOfMarks:(NSInteger)numberOfMarks{
    _image = image;
    _backImage = backImage;
    _numberOfMarks = numberOfMarks;
    [self setNeedsDisplay];
}

- (void)setOffsets:(NSArray *)offsets space:(CGFloat)space{
    _offsets = offsets;
    _space = space;
    [self setNeedsDisplay];
}

- (void)setMarkShowStyle:(WPMarkShowStyle)markShowStyle{
    _markShowStyle = markShowStyle;
    [self setNeedsDisplay];
}

- (void)setMarkValue:(CGFloat)markValue{
    _markValue = markValue;
    [self setNeedsDisplay];
}

- (void)setIsCustomSeat:(BOOL)isCustomSeat{
    _isCustomSeat = isCustomSeat;
    [self setNeedsDisplay];
}

- (void)setCustomFrames:(NSArray *)customFrames{
    _customFrames = customFrames;
    [self setNeedsDisplay];
}

- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (_image) {
        UIImage * image = _image;
        UIImage * backImage = _backImage;
        
        _bounds = CGRectMake(0, 0,
                             (_imageBounds.size.width?_imageBounds.size.width:image.size.width),
                             (_imageBounds.size.height?_imageBounds.size.height:image.size.height)
                             );
        _spacePoint = CGPointMake(
                                  ((_space >= 0)?_space:(self.frame.size.width - _bounds.size.width*_numberOfMarks)/(_numberOfMarks + 1)),
                                  ((_space >= 0)?_space:(self.frame.size.height - _bounds.size.height*_numberOfMarks)/(_numberOfMarks + 1))
                                  );
        
        // 画背景的图
        [self drawImage:backImage bounds:_bounds space:_spacePoint markValue:_numberOfMarks];
        
        // 画前景图
        [self drawImage:image bounds:_bounds space:_spacePoint markValue:_markValue];
    }
}

- (void)drawImage:(UIImage *)image bounds:(CGRect)bounds space:(CGPoint)space markValue:(CGFloat)markValue{
    for (int i = 0; i < markValue; i++) {
        CGRect frame = [self frameWithBounds:bounds space:space index:i];
        [image drawInRect:frame blendMode:kCGBlendModeNormal alpha:1.0f];
    }
}

- (CGFloat)markValueWithOffset:(CGPoint)point{
    CGFloat rtn = 0.0f;
    CGRect frame = CGRectZero;
    int i = 0;
    for (i = 0; i < _numberOfMarks; i++) {
        frame = [self frameWithBounds:_bounds space:_spacePoint index:i];
        if (((_markDirection & WPMarkDirectionHorizontal) && (frame.origin.x > point.x)) || ((_markDirection & WPMarkDirectionVertical) && (frame.origin.y > point.y))) {
            break;
        }
    }
    rtn = i*1.0f;
    return rtn;
}

- (CGRect)frameWithBounds:(CGRect)bounds space:(CGPoint)space index:(NSInteger)index{
    if (_isCustomSeat) {
        return CGRectFromString(_customFrames[index]);
    }
    CGFloat x = (self.frame.size.width - bounds.size.width)/2.0f;
    CGFloat y = (self.frame.size.height - bounds.size.height)/2.0f;
    
    CGRect frame = CGRectMake(x,y, bounds.size.width, bounds.size.height);
    if (_markDirection & WPMarkDirectionHorizontal) {
        frame.origin.x = contentWidth(0, space.x, frame.size.width, index);
        if (_offsets && _offsets.count > index) {
            CGFloat margin = (self.frame.size.width - contentWidth(0, space.x, frame.size.width, _numberOfMarks))/2;
            frame.origin.x = contentWidth(margin, space.x, frame.size.width, index);
            frame.origin.y = [_offsets[index] floatValue];
        }
    }
    if (_markDirection & WPMarkDirectionVertical) {
        frame.origin.y = contentWidth(0, space.y, frame.size.height, index);
        if (_offsets && _offsets.count > index) {
            CGFloat margin = (self.frame.size.width - contentWidth(0, space.y, frame.size.height, _numberOfMarks))/2;
            frame.origin.x = [_offsets[index] floatValue];
            frame.origin.y = contentWidth(margin, space.y, frame.size.height, index);
        }
    }
    return frame;
}

#pragma mark - system
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isSelect) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        _markValue = [self markValueWithOffset:pt];
        [self setNeedsDisplay];
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isSelect) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        _markValue = [self markValueWithOffset:pt];
        [self setNeedsDisplay];
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(markView:selectedScore:)]) {
        [self.delegate markView:self selectedScore:_markValue];
    }
}


@end
