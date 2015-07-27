//
//  TbTableViewCell.m
//  testAutoCell
//
//  Created by buding on 15/7/24.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "TbTableViewCell.h"
#import "AutoRect.h"

@implementation TbModel
@end

@interface TbTableViewCell ()

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


#pragma mark - UIViewAutoRectProtocol
- (CGRect)ar_layoutSuperView {
    CGRect rect = [AutoRectUtil autoLayoutSizeWithTableViewCell:self];
    return rect;
}

- (void)ar_updateConstraints {
    // 自动布局
    NSDictionary * views = NSDictionaryOfVariableBindings(_nameLabel, _profileLabel, _backImageView);
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.profileLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.backImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary * metrics = @{};
    
    // 横向1
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_nameLabel]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
    // 横向2
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_profileLabel]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
    // 横向3
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_backImageView]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
    // 纵向1
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_nameLabel][_profileLabel]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
    // 纵向2
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_backImageView]-10-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
}

#pragma mark - ()
- (void)setModel:(TbModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.profileLabel.attributedText = [self attributedStringWithExpString:model.profile markString:@"Mark"];
    self.backImageView.image = [UIImage imageNamed:model.imageUrl];
    [self ar_setNeedsLayout];
}

@end
