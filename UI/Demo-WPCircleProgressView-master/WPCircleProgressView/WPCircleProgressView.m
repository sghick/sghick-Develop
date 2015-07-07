//
//  WPCircleProgressView.m
//  WisdomPark
//
//  Created by 丁治文 on 15/3/12.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPCircleProgressView.h"

#define WPDegreesToRadians(a) ((a)*M_PI/180.0f)

@implementation WPCircleProgressView{
    // 轨迹层
    CAShapeLayer * _trackLayer;
    // 进度层
    CAShapeLayer * _progressLayer;
    // 渐变层
    CALayer * _gradientLayer;
}

// 路径颜色
@synthesize trackTintColor = _trackTintColor;
// 进度条颜色
@synthesize progressTintColor = _progressTintColor;
// 进度
@synthesize progress = _progress;
// 起点弧度 M_PI
@synthesize startRadians = _startRadians;
// 环的宽度
@synthesize pathWidth = _pathWidth;
// 是否设置圆角
@synthesize rounded = _rounded;
// 是否设置渐变色
@synthesize gradually = _gradually;
// 半径
@synthesize radius = _radius;


- (id)init{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    if (self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    // 圆心
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    // 半径
    CGFloat radius = self.radius;
    // 路径宽度
    CGFloat pathWidth = radius*0.3f;
    // 如果设置了宽度则使用宽度
    if (self.pathWidth) {
        pathWidth = self.pathWidth;
    }
    if (!_trackLayer) {
        // 画背景圆
        _trackLayer = [self roundLayerWithCenterPoint:centerPoint radius:radius - pathWidth/2 pathWidth:pathWidth radians:2*M_PI isRounded:self.rounded color:self.trackTintColor];
        [self.layer addSublayer:_trackLayer];
    }
    
    if (!_progressLayer) {
        // 画进度圆
        _progressLayer = [self roundLayerWithCenterPoint:centerPoint radius:radius - pathWidth/2 pathWidth:pathWidth radians:2*M_PI isRounded:self.rounded color:self.progressTintColor];
        // 渐变色填充
        if (self.gradually) {
            // 渐变层
            _gradientLayer = [self graduallyLayerWithGradientColors:self.gradientColors];
            // 用progressLayer来截取渐变层
            [_gradientLayer setMask:_progressLayer];
            [self.layer addSublayer:_gradientLayer];
        }
        else{
            // 把圆加入layer
            [self.layer addSublayer:_progressLayer];
        }
    }
    
    // 旋转来设置起始点
    if (self.startRadians){
        self.transform = CGAffineTransformMakeRotation(self.startRadians);
    }
}

// 画圆
- (CAShapeLayer *)roundLayerWithCenterPoint:(CGPoint)centerPoint radius:(CGFloat)radius pathWidth:(CGFloat)pathWidth radians:(CGFloat)radians isRounded:(BOOL)isRounded color:(UIColor *)color{
    CAShapeLayer * rtn = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:-M_PI_2 endAngle:radians - M_PI_2 clockwise:YES];
    rtn.frame = self.bounds;
    rtn.fillColor = [[UIColor clearColor] CGColor];
    rtn.strokeColor = [color CGColor];
    rtn.opacity = 1.0f;
    rtn.lineCap = kCALineCapButt;
    if (isRounded) {
        rtn.lineCap = kCALineCapRound;
    }
    rtn.lineWidth = pathWidth;
    rtn.path =[path CGPath];
    rtn.strokeEnd = 0;
    return rtn;
}

// 渐变层
- (CALayer *)graduallyLayerWithGradientColors:(NSArray *)gradientColors{
    CALayer * rtn = [CALayer layer];
    NSArray * defaultColors = gradientColors;
    if (!gradientColors || gradientColors.count <= 0) {
        defaultColors = @[
                          (id)[UIColor greenColor].CGColor, (id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor,
                          (id)[UIColor brownColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor blueColor].CGColor
                          ];
    }
    // 计算传进来颜色的位置
    NSMutableArray * locations = [[NSMutableArray alloc] initWithCapacity:defaultColors.count];
    for (int i = 0; i < defaultColors.count; i++) {
        [locations addObject:[NSNumber numberWithFloat:i*1.0f/defaultColors.count]];
    }
    CAGradientLayer * gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [gradientLayer setColors:defaultColors];
    [gradientLayer setLocations:locations];
    [gradientLayer setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer setEndPoint:CGPointMake(0.5, 0)];
    [rtn addSublayer:gradientLayer];
    return rtn;
}

#pragma mark - Property Methods

- (UIColor *)trackTintColor {
    if (!_trackTintColor){
        _trackTintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.3f];
    }
    return _trackTintColor;
}

- (UIColor *)progressTintColor {
    if (!_progressTintColor){
        _progressTintColor = [UIColor redColor];
    }
    return _progressTintColor;
}

- (CGFloat)radius {
    if (!_radius) {
        _radius = MIN(self.frame.size.width, self.frame.size.height)/2 - self.margin;
    }
    return  _radius;
}

- (void)setRadius:(CGFloat)radius{
    _radius = radius;
    [self setNeedsDisplay];
}

- (void)setMargin:(CGFloat)margin{
    _margin = margin;
    [self setNeedsDisplay];
}

- (void)setRounded:(BOOL)rounded {
    _rounded = rounded;
    [self setNeedsRedraw];
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    [self setNeedsRedraw];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    [self setNeedsRedraw];
}

- (void)setGradually:(BOOL)gradually {
    _gradually = gradually;
    [self setNeedsRedraw];
}

- (void)setGradientColors:(NSArray *)gradientColors {
    _gradientColors = [self cgcolors:gradientColors];
    [self setNeedsRedraw];
}

// 兼容UIColor
- (NSArray *)cgcolors:(NSArray *)colors {
    BOOL needLog = NO;
    NSMutableArray * rtns = [[NSMutableArray alloc] initWithCapacity:0];
    for (UIColor * color in colors) {
        if ([color isKindOfClass:[UIColor class]]) {
            needLog = YES;
            [rtns addObject:(id)color.CGColor];
        }
    }
    if (needLog) {
        NSLog(@"WPCircleProgressView:params gradientColors' type might be CGColor");
        return rtns;
    }
    else {
        return colors;
    }
}

// 需要重画
- (void)setNeedsRedraw {
    if (_trackLayer) {
        [_trackLayer removeFromSuperlayer];
        _trackLayer = nil;
    }
    if (_progressLayer) {
        [_progressLayer removeFromSuperlayer];
        _progressLayer = nil;
    }
    if (_gradientLayer) {
        [_gradientLayer removeFromSuperlayer];
        _gradientLayer = nil;
    }
    [self setProgress:_progress];
}
#pragma mark - function

/**
 *  不带动画设置进度
 *
 *  @param progress 进度
 */
- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO animatedDuration:0.0f];
}

/**
 *  设置进度
 *
 *  @param progress         进度
 *  @param animated         是否动画
 *  @param animatedDuration 动画时间戳
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated animatedDuration:(CGFloat)animatedDuration {
    _progress = progress;
    if (!_progressLayer) {
        [self drawRect:self.frame];
    }
    _progressLayer.strokeEnd = 0;
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:animatedDuration];
    _progressLayer.strokeEnd = progress;
    [CATransaction commit];
    [self setNeedsDisplay];
}

/**
 *  取到当前进度的圆上的点
 *
 *  @param progress 进度
 *
 *  @return 圆上的点
 */
- (CGPoint)pointWithProgress:(CGFloat)progress{
    // 半径
    CGPoint rtn = [self pointWithProgress:progress radius:self.radius];
    return rtn;
}

/**
 *  取到当前进度的圆上的点
 *
 *  @param progress 进度
 *  @param radius   圆的半径
 *
 *  @return 取到当前进度的圆上的点
 */
- (CGPoint)pointWithProgress:(CGFloat)progress radius:(CGFloat)radius{
    // 弧度
    CGFloat radians = 2*M_PI*progress+self.startRadians;
    // 圆心
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint rtn = CGPointMake(centerPoint.x + radius*sinf(radians), centerPoint.y - radius*cosf(radians));
    return rtn;
}

@end
