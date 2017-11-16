//
//  SUSongListCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/16.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUSongListCell.h"
#import "UIView+Layout.h"
#import "UIImage+Size.h"

@interface SUSongListCell()
@property(nonatomic, strong) UIImageView *mvImageView;
@property(nonatomic, strong) UIImageView *optImageView;
@end

@implementation SUSongListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    style = UITableViewCellStyleSubtitle;
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView.image = [[UIImage imageNamed:@"cm2_btm_icn_account"] imageWithSize:CGSizeMake(15, 15)];
        self.imageView.hidden = YES;
        [self.contentView addSubview:self.indexLabel];
        [self.contentView addSubview:self.mvImageView];
        [self.contentView addSubview:self.optImageView];
        self.textLabel.text = @"清华池,打发斯蒂芬斯蒂芬";
        self.detailTextLabel.text = @"周杰伦";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indexLabel.center = self.imageView.center;
    
    self.accessoryView = self.optImageView;
    
    self.mvImageView.centerY = self.size.height/2;
    self.mvImageView.right   = self.optImageView.left - 20;
}


- (UILabel *)indexLabel {
    if(!_indexLabel) {
        _indexLabel         = [UILabel new];
        _indexLabel.frame   = CGRectMake(0, 0, 30, 30);
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.text    = @"1";
    }
    return _indexLabel;
}

- (UIImageView *)mvImageView {
    if(!_mvImageView) {
        _mvImageView        = [UIImageView new];
        _mvImageView.frame  = CGRectMake(0, 0, 30, 30);
        _mvImageView.image  = [UIImage imageNamed:@"image"];
    }
    return _mvImageView;
}

- (UIImageView *)optImageView {
    if(!_optImageView) {
        _optImageView       = [UIImageView new];
        _optImageView.frame = CGRectMake(0, 0, 30, 30);
        _optImageView.image = [UIImage imageNamed:@"image"];
    }
    return _optImageView;
}

@end
