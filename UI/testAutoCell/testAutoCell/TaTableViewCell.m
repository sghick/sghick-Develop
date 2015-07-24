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

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TaTableViewCell

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


#pragma mark - UIViewAutoRectProtocol
- (CGRect)ar_layoutSuperView {
    CGRect rect = CGRectZero;
    CGRect rect1 = [AutoRectUtil autoSizeWithLabel:self.titleLabel];
    CGRect rect2 = [AutoRectUtil autoSizeWithImage:self.backImageView.image];
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    rect.size.height = rect1.size.height + rect2.size.height + 20;
    return rect;
}

- (void)ar_drawRect:(CGRect)rect {
    self.backImageView.frame = CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20);
    self.titleLabel.frame = CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20);
}

#pragma mark - ()
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self ar_setNeedsLayout];
}


@end
