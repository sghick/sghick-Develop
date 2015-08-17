//
//  AppDelegate.m
//  DevelopToolsForMac
//
//  Created by 丁治文 on 15/6/8.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "AppDelegate.h"
#import "SGTool.h"
#import "SGConfigHeader.h"
#import "SGCommonHeader.h"

@interface AppDelegate ()<NSComboBoxDataSource, NSComboBoxDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) SGTool * tool;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // 配置应用程序
    [self setupApp];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

- (void)setupApp{
    SGConfigManager * manager = [SGConfigManager defaultConfigManager];
    // 数据源
    self.dataSource = [manager.configs.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [comboBox reloadData];
    // 读取配置
    NSInteger curIndex = [self.dataSource indexOfObject:manager.curItemName];
    [comboBox selectItemAtIndex:curIndex];
}

#pragma mark - NSComboBoxDataSource, NSComboBoxDelegate
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    return self.dataSource.count;
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index{
    return self.dataSource[index];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    // 读取配置
    SGConfigManager * manager = [SGConfigManager defaultConfigManager];
    manager.curItemName = self.dataSource[comboBox.indexOfSelectedItem];
    [manager save];
    [inputMatrix selectCellWithTag:manager.curConfig.inputType.intValue];
    [outputMatrix selectCellWithTag:manager.curConfig.outputType.intValue];
    
    // 设置执行工具类
    self.tool = [[SGTool alloc] initWithClassName:manager.curConfig.className];
}

#pragma mark - ()
- (IBAction)searchFiledValueChanged:(id)sender {
    static NSString * sst = nil;
    if (![sst isEqualToString:searchFiled.stringValue]) {
        sst = searchFiled.stringValue;
        int index = [self indexOfSearchText:sst inArray:self.dataSource];
        [comboBox selectItemAtIndex:index];
    }
}

- (IBAction)inputMatrixClick:(id)sender {
    SGConfigManager * manager = [SGConfigManager defaultConfigManager];
    manager.curConfig.inputType = SGToString(@"%zi", inputMatrix.selectedTag);
    [manager save];
}

- (IBAction)outputMatrixClick:(id)sender {
    SGConfigManager * manager = [SGConfigManager defaultConfigManager];
    manager.curConfig.outputType = SGToString(@"%zi", outputMatrix.selectedTag);
    [manager save];
}

- (IBAction)excuteBtnClick:(id)sender {
    SGConfigManager * manager = [SGConfigManager defaultConfigManager];
    [self.tool setupBlock:^id{
        if (!manager.curConfig.inputType.boolValue) {
            return inputTextView.string;
        }
        else{
            return [NSString stringWithContentsOfFile:inputTextView.string encoding:NSUTF8StringEncoding error:nil];
        }
    } resultBlock:^(id result) {
        if (!manager.curConfig.outputType.boolValue) {
            outputTextView.string = result;
        }
        else{
            [result writeToFile:outputTextView.string atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    }];
    [self.tool startThread];
}

- (IBAction)helpBtnClick:(id)sender {
    SGConfigManager * manager = [SGConfigManager defaultConfigManager];
    outputTextView.string = manager.curConfig.helpMsg;
}

- (int)indexOfSearchText:(NSString *)searchText inArray:(NSArray *)array {
    for (NSString * item in array) {
        // 智能匹配
        if ([item containsIntelligentString:searchText]) {
            return (int)[array indexOfObject:item];
        }
    }
    return 0;
}

@end
