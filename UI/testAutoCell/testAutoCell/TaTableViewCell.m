//
//  TaTableViewCell.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "TaTableViewCell.h"
#import "UITableViewCell+AutoSize.h"

@interface TaTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.clipsToBounds = NO;
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

#pragma mark - getter/setter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}


#pragma mark - UITableViewCellAutoSizeProtocol
// 也可以写在 updateConstraints 方法中，但是不要忘记加 “[super updateConstraints];" 哦
- (void)ar_updateConstraints {
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_titleLabel);
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary * metrics = @{};
    
    // 横向1
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLabel]-10-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    // 纵向1
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
    
    // 请务必要设置Label的最大宽值
    [self.titleLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 20];
}

#pragma mark - ()
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}


@end
