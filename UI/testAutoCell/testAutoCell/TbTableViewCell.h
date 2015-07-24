//
//  TbTableViewCell.h
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *profile;
@property (strong, nonatomic) NSString *imageUrl;

@end

@interface TbTableViewCell : UITableViewCell

@property (strong, nonatomic) TbModel *model;

@end
