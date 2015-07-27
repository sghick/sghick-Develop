//
//  TaTableViewCell.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "TaTableViewCell.h"
#import "AutoRect.h"

@interface TaTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
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


#pragma mark - UIViewAutoRectProtocol
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
}

#pragma mark - ()
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self ar_setNeedsLayoutWithDrawRect:CGRectMake(0, 0, 10, 10)];
}


@end
