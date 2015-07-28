//
//  TbTableViewCell.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "TbTableViewCell.h"
#import "UITableViewCell+AutoSize.h"
#import "AutoSizeUtil.h"

@implementation TbModel
@end

@interface TbTableViewCell ()<UITableViewCellAutoSizeProtocol>

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *profileLabel;

@end

@implementation TbTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.backImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.profileLabel];
    }
    return self;
}

#pragma mark - getter/setter
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor clearColor];
    }
    return _backImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}

- (UILabel *)profileLabel {
    if (!_profileLabel) {
        _profileLabel = [[UILabel alloc] init];
        _profileLabel.numberOfLines = 0;
        _profileLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _profileLabel.backgroundColor = [UIColor clearColor];
    }
    return _profileLabel;
}

- (NSAttributedString *)attributedStringWithExpString:(NSString *)expString markString:(NSString *)markString {
    NSMutableAttributedString *rtn = [[NSMutableAttributedString alloc] initWithString:expString];
    NSRange range = [expString rangeOfString:markString];
    // 调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];
    [rtn addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, rtn.length)];
    [rtn addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, rtn.length)];
    [rtn addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
    [rtn addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, rtn.length)];
    [rtn addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:40] range:range];
    return rtn;
}


#pragma mark - UITableViewCellAutoSizeProtocol

/**
 *  ar_layoutSuperView 和 ar_drawRect:(CGRect)rect 是直接设置frame的方法（注意，自动约束会让此方法失效）
 */
- (CGRect)ar_layoutSuperView {
    CGRect frame = CGRectZero;
    CGRect nameLabelFrame = [AutoSizeUtil autoSizeWithLabel:self.nameLabel];
    CGRect profileLabelFrame = [AutoSizeUtil autoSizeWithLabel:self.profileLabel];
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = nameLabelFrame.size.height + profileLabelFrame.size.height + 20;
    return frame;
}

- (void)ar_drawRect:(CGRect)rect {
    CGRect nameLabelFrame = [AutoSizeUtil autoSizeWithLabel:self.nameLabel];
    self.nameLabel.frame = CGRectMake(
                                      10,
                                      10,
                                      nameLabelFrame.size.width,
                                      nameLabelFrame.size.height
                                      );
    
    CGRect profileLabelFrame = [AutoSizeUtil autoSizeWithLabel:self.profileLabel];
    self.profileLabel.frame = CGRectMake(
                                         10,
                                         self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height,
                                         profileLabelFrame.size.width,
                                         profileLabelFrame.size.height
                                         );
    
    CGRect backImageViewFrame = CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20);
    self.backImageView.frame = backImageViewFrame;
}

/**
 *  第一种添加约束的方法
 */
//- (void)updateConstraints {
//    [super updateConstraints];
//    // 自动布局
//    NSDictionary * views = NSDictionaryOfVariableBindings(_nameLabel, _profileLabel, _backImageView);
//    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.profileLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.backImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSDictionary * metrics = @{};
//    
//    // 横向1
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_nameLabel]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 横向2
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_profileLabel]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 横向3
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_backImageView]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 纵向1
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_nameLabel][_profileLabel]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 纵向2
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_backImageView]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    
//    // 请务必要设置Label的最大宽值
//    [self.nameLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 20];
//    [self.profileLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 20];
//}

/**
 *  第二种添加约束的方法
 */
//- (void)ar_updateConstraints {
//    // 自动布局
//    NSDictionary * views = NSDictionaryOfVariableBindings(_nameLabel, _profileLabel, _backImageView);
//    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.profileLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.backImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSDictionary * metrics = @{};
//    
//    // 横向1
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_nameLabel]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 横向2
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_profileLabel]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 横向3
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_backImageView]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 纵向1
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_nameLabel][_profileLabel]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    // 纵向2
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_backImageView]-10-|"
//                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
//                                                                             metrics:metrics
//                                                                               views:views]];
//    
//    // 请务必要设置Label的最大宽值
//    [self.nameLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 20];
//    [self.profileLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 20];
//}

#pragma mark - ()
- (void)setModel:(TbModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.profileLabel.attributedText = [self attributedStringWithExpString:model.profile markString:@"Mark"];
    self.backImageView.image = [UIImage imageNamed:model.imageUrl];
}

@end
