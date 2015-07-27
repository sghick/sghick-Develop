//
//  TestTableViewCell.m
//  Demo-AutoTableViewCell
//
//  Created by 丁治文 on 15/7/23.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell ()<AutoTableViewCellProtocol>

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.backImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - getter/setter
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor yellowColor];
    }
    return _backImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.backgroundColor = [UIColor cyanColor];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self setNeedLayoutWithAutoRect];
}

#pragma mark - AutoTableViewCellProtocol
+ (CGRect)autoRectWithCell:(TestTableViewCell *)cell {
    TestTableViewCell * pCell = (TestTableViewCell *)cell;
    CGRect rect = CGRectZero;
    CGRect rect1 = [super autoSizeWithLabel:pCell.titleLabel];
    CGRect rect2 = [super autoSizeWithImage:pCell.backImageView.image];
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    rect.size.height = rect1.size.height + rect2.size.height + 20;
    return rect;
}

- (void)autoRectWithDrawRect:(CGRect)rect {
    self.backImageView.frame = CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20);
    self.titleLabel.frame = CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20);
}
@end
