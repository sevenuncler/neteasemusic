//
//  MVViewCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "MVViewCell.h"
#import "UIView+Layout.h"

@implementation MVViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.coverIV];
        [self.contentView addSubview:self.nameL];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat padding = 10;
    CGFloat width   = self.size.width;
    CGFloat height  = width * 0.618;
    
    self.coverIV.size = CGSizeMake(width, height);
    self.coverIV.top = 0;
    self.coverIV.left = 0;
    
    self.nameL.size = CGSizeMake(width, 0);
    [self.nameL sizeToFit];
    self.nameL.left = padding;
    self.nameL.top  = self.coverIV.botton + padding;
}

#pragma mark - Getter

- (UIImageView *)coverIV {
    if(!_coverIV) {
        _coverIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    }
    return _coverIV;
}

- (UILabel *)nameL {
    if(!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.font = [UIFont systemFontOfSize:11];
        _nameL.text = @"歌曲名称(未知)";
        _nameL.numberOfLines = 0;
    }
    return _nameL;
}

@end
