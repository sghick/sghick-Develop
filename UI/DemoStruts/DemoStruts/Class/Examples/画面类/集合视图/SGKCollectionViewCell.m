//
//  SGKCollectionViewCell.m
//  DemoStruts
//
//  Created by 丁治文 on 15/1/12.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#import "SGKCollectionViewCell.h"

@implementation SGKCollectionViewCell{
    UILabel * _label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [_label setTag:10];
        [_label setFont:[UIFont boldSystemFontOfSize:25]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setTextColor:[UIColor cyanColor]];
        [_label setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setCellWithModel:(NSString *)title{
    [_label setText:title];
}


@end
