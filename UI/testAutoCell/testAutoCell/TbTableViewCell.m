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
    CGRect rect = CGRectZero;
    CGRect rect1 = [AutoRectUtil autoSizeWithLabel:self.nameLabel];
    CGRect rect2 = [AutoRectUtil autoSizeWithLabel:self.profileLabel];
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    rect.size.height = 40 + rect1.size.height + rect2.size.height;
    return rect;
}

- (void)ar_drawRect:(CGRect)rect {
    self.backImageView.frame = CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20);
    
    CGRect rect1 = [AutoRectUtil autoSizeWithLabel:self.nameLabel];
    rect1.origin.x = self.backImageView.frame.origin.x;
    rect1.origin.y = self.backImageView.frame.origin.y + 10;
    self.nameLabel.frame = rect1;
    
    CGRect rect2 = [AutoRectUtil autoSizeWithLabel:self.profileLabel];
    rect2.origin.x = rect1.origin.x;
    rect2.origin.y = rect1.origin.y + rect1.size.height;
    self.profileLabel.frame = rect2;
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
