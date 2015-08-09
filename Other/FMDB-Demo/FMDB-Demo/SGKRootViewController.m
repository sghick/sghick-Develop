//
//  SGKRootViewController.m
//  FMDB-Demo
//
//  Created by qf on 14-10-31.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "SGKRootViewController.h"
#import "SGKUserDao.h"
#import "SGKUser.h"

@interface SGKRootViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
- (IBAction)addUser:(UIButton *)sender;
- (IBAction)deleteUser:(UIButton *)sender;
- (IBAction)updateUser:(UIButton *)sender;
- (IBAction)searchUser:(UIButton *)sender;
- (IBAction)clear:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *uidField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (strong, nonatomic) NSArray * dataSource;
@property (strong, nonatomic) SGKUser * curUser;

@property (strong, nonatomic) SGKUserDao *dao;

@end

@implementation SGKRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SGKUserDao *dao = [[SGKUserDao alloc] init];
    self.dao = dao;
    [self searchUser:nil];
}

- (IBAction)addUser:(UIButton *)sender {
    NSString *name = self.nameField.text;
    NSString *age = self.ageField.text;
    NSString *uid = self.uidField.text;
    if (name.length==0 || age.length==0) {
        NSLog(@"不能为空");
        return;
    }
    SGKUser *user = [[SGKUser alloc] init];
    user.uid = uid;
    user.name = name;
    user.age = age;
    BOOL isSuccess = [self.dao insertUsers:@[user]];
    if (!isSuccess) {
        NSLog(@"插入失败!");
    }
    else{
        NSLog(@"插入成功");
        [self searchUser:nil];
    }
}

- (IBAction)deleteUser:(UIButton *)sender {
    if (self.curUser == nil) {
        NSLog(@"请选择一项");
        return;
    }
    BOOL isSuccess = [self.dao deleteUsersWithUid:self.curUser.uid];
    if (!isSuccess) {
        NSLog(@"删除失败!");
    }
    else{
        NSLog(@"删除成功");
        [self searchUser:nil];
    }
}

- (IBAction)updateUser:(UIButton *)sender {
    NSString * name = self.nameField.text;
    NSString * age = self.ageField.text;
    NSString * uid = self.uidField.text;
    if (self.curUser == nil) {
        NSLog(@"请选择一项");
        return;
    }
    if (name.length==0 || age.length==0) {
        NSLog(@"不能为空");
        return;
    }
    SGKUser *user = [[SGKUser alloc] init];
    user.uid = uid;
    user.name = name;
    user.age = age;
    BOOL isSuccess = [self.dao updateUsers:@[user]];
    if (!isSuccess) {
        NSLog(@"更新失败!");
    }
    else{
        NSLog(@"更新成功");
        [self searchUser:nil];
    }
}

- (IBAction)searchUser:(UIButton *)sender {
    NSString *uid = self.uidField.text;
    NSArray *array = nil;
    if (uid && uid.length) {
        array = [self.dao searchUsersWithUserId:uid];
    } else {
        array = [self.dao searchUsers];
    }
    self.dataSource = array;
    [self.userTableView reloadData];
}

- (IBAction)clear:(UIButton *)sender {
    self.uidField.text = @"";
    self.nameField.text = @"";
    self.ageField.text = @"";
}

#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if (self.dataSource.count > 0) {
        SGKUser * user = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = user.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@岁", user.age];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.curUser = [self.dataSource objectAtIndex:indexPath.row];
    self.uidField.text = self.curUser.uid;
    self.nameField.text = self.curUser.name;
    self.ageField.text = [NSString stringWithFormat:@"%@", self.curUser.age];
}

@end
