//
//  SMBaseViewController.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMBaseViewControllerProtocol <NSObject>

- (void)loadData;

- (void)loadUI;

- (void)loadUIData;

- (void)loadUIFrame;

@end

@interface SMBaseViewController : UIViewController<SMBaseViewControllerProtocol>

@end
