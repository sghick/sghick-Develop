//
//  AppDelegate.h
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSSearchField * searchFiled;
    IBOutlet NSComboBox * comboBox;
    IBOutlet NSMatrix * inputMatrix;
    IBOutlet NSMatrix * outputMatrix;
    IBOutlet NSTextView * inputTextView;
    IBOutlet NSTextView * outputTextView;
    IBOutlet NSButton * excuteBtn;
    IBOutlet NSProgressIndicator * progress;
}

- (IBAction)searchFiledValueChanged:(id)sender;
- (IBAction)inputMatrixClick:(id)sender;
- (IBAction)outputMatrixClick:(id)sender;
- (IBAction)excuteBtnClick:(id)sender;

@end

