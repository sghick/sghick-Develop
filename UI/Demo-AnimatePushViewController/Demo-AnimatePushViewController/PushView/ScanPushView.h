//
//  ScanPushView.h
//  Demo-AnimatePushViewController
//
//  Created by buding on 15/7/8.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "PushView.h"

#define TAG_VIDEO   101
#define TAG_HELP    102

@class ScanPushView;
@protocol ScanPushViewDelegate <NSObject>

- (void)scanPushView:(ScanPushView *)scanPushView videoButtonTouched:(UIButton *)videoButton;
- (void)scanPushView:(ScanPushView *)scanPushView helpButtonTouched:(UIButton *)helpButton;

@end

@interface ScanPushView : PushView<PushView>

@property (assign, nonatomic) id<ScanPushViewDelegate> scanPushViewDelegate;

@end
