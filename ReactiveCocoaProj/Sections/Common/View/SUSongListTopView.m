//
//  SUSongListTopView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUSongListTopView.h"
#import "UIView+Layout.h"

@interface SUSongListTopView ()
@property(nonatomic, strong) UIButton *likedMenuBtn;
@property(nonatomic, strong) UIButton *commentMenuBtn;
@property(nonatomic, strong) UIButton *tranMenuBtn;
@property(nonatomic, strong) UIButton *downloadMenuBtn;
@end

@implementation SUSongListTopView
@synthesize coverIV         = _coverIV;
@synthesize avatorIV        = _avatorIV;
@synthesize nameLabel       = _nameLabel;
@synthesize likedNumLabel   = _likedNumLabel;
@synthesize commentNumLabel = _commentNumLabel;
@synthesize trandNumLabel   = _trandNumLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.coverIV];
        [self addSubview:self.nameLabel];
        [self addSubview:self.avatorIV];
        [self addSubview:self.likedMenuBtn];
        [self addSubview:self.likedNumLabel];
        [self setUpSubViewsLayout];
    }
    return self;
}

- (void)setUpSubViewsLayout {
    //封面
    self.coverIV.size = CGSizeMake(kCoverSize, kCoverSize);
    self.coverIV.left = kPadding*2;
    self.coverIV.top  = kPadding*2;
    
    //歌单名称
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.size = CGSizeMake(170, 0);
    self.nameLabel.left = self.coverIV.right + 2*kPadding;
    self.nameLabel.top  = self.coverIV.top + 3*kPadding;
    
    //头像
    self.avatorIV.size = CGSizeMake(kAvatorSize, kAvatorSize);
    self.avatorIV.left = self.nameLabel.left;
    
    //收藏
    self.likedMenuBtn.size = CGSizeMake(kMenuSize, kMenuSize);
    self.likedMenuBtn.left = 5*kPadding;
    self.likedMenuBtn.top  = self.coverIV.botton + 3*kPadding;
    self.likedNumLabel.top     = self.likedMenuBtn.botton + kPadding;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
     
    CGSize size = [self.nameLabel sizeThatFits:self.nameLabel.size];
    self.nameLabel.size = CGSizeMake(self.nameLabel.size.width, size.height);
    
    self.avatorIV.top  = self.nameLabel.botton + kPadding;

    [self.likedNumLabel sizeToFit];
    self.likedNumLabel.centerX = self.likedMenuBtn.centerX;

    
}

- (UIImageView *)coverIV {
    if(!_coverIV) {
        _coverIV = [UIImageView new];
        _coverIV.image = [UIImage imageNamed:@"image"];
    }
    return _coverIV;
}

- (UIImageView *)avatorIV {
    if(!_avatorIV) {
        _avatorIV = [UIImageView new];
        _avatorIV.image = [UIImage imageNamed:@"image"];
    }
    return _avatorIV;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"和红楼鞥中去，谭进一会春,和红楼鞥中去，谭进一会春和红楼鞥中去，谭进一会春";
    }
    return _nameLabel;
}

- (UILabel *)commentNumLabel {
    if(!_commentNumLabel) {
        _commentNumLabel = [UILabel new];
        _commentNumLabel.text = @"99999";
        _commentNumLabel.font = [UIFont systemFontOfSize:kFontSize];
    }
    return _commentNumLabel;
}

- (UILabel *)likedNumLabel {
    if(!_likedNumLabel) {
        _likedNumLabel = [UILabel new];
        _likedNumLabel.text = @"9999";
        _likedNumLabel.font = [UIFont systemFontOfSize:kFontSize];
    }
    return _likedNumLabel;
}

- (UILabel *)trandNumLabel {
    if(!_trandNumLabel) {
        _trandNumLabel = [UILabel new];
    }
    return _trandNumLabel;
}

- (UIButton *)likedMenuBtn {
    if(!_likedMenuBtn) {
        _likedMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likedMenuBtn setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _likedMenuBtn;
}



@end
