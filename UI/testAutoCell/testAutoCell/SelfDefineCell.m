//
//  SelfDefineCell.m
//  testAutoCell
//
//  Created by buding on 15/7/22.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "SelfDefineCell.h"

@interface SelfDefineCell ()<AutoTableViewCellProtocol>

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation SelfDefineCell

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


#pragma mark - ()
- (void)setSubviewWithFrame:(CGRect)frame {
    self.backImageView.frame = CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20);
    self.titleLabel.frame = CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self setCell];
}

#pragma mark - AutoTableViewCellProtocol
+ (CGFloat)autoHeightWithCell:(AutoTableViewCell *)cell {
    SelfDefineCell * pCell = (SelfDefineCell *)cell;
    CGSize size1 = [super autoSizeWithLabel:pCell.titleLabel];
    CGSize size2 = [super autoSizeWithImage:pCell.backImageView.image];
    [pCell setSubviewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size1.height + 20)];
    return size1.height + size2.height + 20;
}

@end
