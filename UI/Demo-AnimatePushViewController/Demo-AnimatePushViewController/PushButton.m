//
//  PushButton.m
//  Demo-AnimatePushViewController
//
//  Created by 丁治文 on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "PushButton.h"

@implementation PushButton

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, point)) {
        if (!self.pushView) {
            UIView *pushView = [[UIView alloc] initWithFrame:[self convertRect:self.superview.frame fromView:self]];
            pushView.backgroundColor = self.backgroundColor;
            [self addSubview:pushView];
            self.pushView = pushView;
        }
        
        self.pushView.alpha = 0.0f;
        self.pushView.backgroundColor = [UIColor blueColor];
        [UIView animateWithDuration:1.0f animations:^{
            self.pushView.frame = [UIScreen mainScreen].bounds;
            self.pushView.alpha = 1.0f;
        } completion:^(BOOL finished) {
//            [self sendActionsForControlEvents:UIControlEventTouchUpInside];
            NSLog(@"animated");
        }];
    }
}

@end
