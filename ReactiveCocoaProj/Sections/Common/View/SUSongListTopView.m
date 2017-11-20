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
@property(nonatomic, strong) UILabel  *downloadLabel;

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
        [self addSubview:self.commentMenuBtn];
        [self addSubview:self.commentNumLabel];
        [self addSubview:self.tranMenuBtn];
        [self addSubview:self.trandNumLabel];
        [self addSubview:self.downloadMenuBtn];
        [self addSubview:self.downloadLabel];
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
    self.avatorIV.layer.cornerRadius = kAvatorSize/2;
    self.avatorIV.layer.masksToBounds = YES;
    self.avatorIV.left = self.nameLabel.left;
    
    CGFloat space = (self.size.width - kMenuSize*4) / 8;
    //收藏
    self.likedMenuBtn.size = CGSizeMake(kMenuSize, kMenuSize);
    self.likedMenuBtn.left = space;
    self.likedMenuBtn.top  = self.coverIV.botton + 3*kPadding;
    self.likedNumLabel.top     = self.likedMenuBtn.botton + kPadding;
    //评论
    self.commentMenuBtn.size = CGSizeMake(kMenuSize, kMenuSize);
    self.commentMenuBtn.left = self.likedMenuBtn.right + 2*space;
    self.commentMenuBtn.centerY = self.likedMenuBtn.centerY;
    self.commentNumLabel.top    =   self.commentMenuBtn.botton + kPadding;
    //分享
    self.tranMenuBtn.size   =   CGSizeMake(kMenuSize, kMenuSize);
    self.tranMenuBtn.left   =   self.commentMenuBtn.right + 2*space;
    self.tranMenuBtn.centerY    =   self.likedMenuBtn.centerY;
    self.trandNumLabel.top      =   self.tranMenuBtn.botton + kPadding;
    //下载
    self.downloadMenuBtn.size   = CGSizeMake(kMenuSize, kMenuSize);
    self.downloadMenuBtn.left   = self.tranMenuBtn.right + 2*space;
    self.downloadMenuBtn.centerY = self.likedMenuBtn.centerY;
    self.downloadLabel.top      = self.downloadMenuBtn.botton + kPadding;
    self.downloadLabel.centerX  = self.downloadMenuBtn.centerX;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
     
    CGSize size = [self.nameLabel sizeThatFits:self.nameLabel.size];
    self.nameLabel.size = CGSizeMake(self.nameLabel.size.width, size.height);
    
    self.avatorIV.top  = self.nameLabel.botton + kPadding;

    [self.likedNumLabel sizeToFit];
    self.likedNumLabel.centerX = self.likedMenuBtn.centerX;
    
    [self.commentNumLabel sizeToFit];
    self.commentNumLabel.centerX = self.commentMenuBtn.centerX;
    
    [self.trandNumLabel sizeToFit];
    self.trandNumLabel.centerX = self.tranMenuBtn.centerX;
    

    
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
        _likedNumLabel.text = @"99999";
        _likedNumLabel.font = [UIFont systemFontOfSize:kFontSize];
    }
    return _likedNumLabel;
}

- (UILabel *)trandNumLabel {
    if(!_trandNumLabel) {
        _trandNumLabel = [UILabel new];
        _trandNumLabel.font = [UIFont systemFontOfSize:kFontSize];
        _trandNumLabel.text = @"99999";

    }
    return _trandNumLabel;
}

- (UILabel *)downloadLabel {
    if(nil == _downloadLabel) {
        _downloadLabel = [UILabel new];
        _downloadLabel.font = [UIFont systemFontOfSize:kFontSize];
        _downloadLabel.text = @"下载";
        [_downloadLabel sizeToFit];
    }
    return _downloadLabel;
}

- (UIButton *)likedMenuBtn {
    if(!_likedMenuBtn) {
        _likedMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likedMenuBtn setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _likedMenuBtn;
}

- (UIButton *)commentMenuBtn {
    if(!_commentMenuBtn) {
        _commentMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentMenuBtn setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _commentMenuBtn;
}

- (UIButton *)tranMenuBtn {
    if(!_tranMenuBtn) {
        _tranMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tranMenuBtn setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _tranMenuBtn;
}

- (UIButton *)downloadMenuBtn {
    if(!_downloadMenuBtn) {
        _downloadMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadMenuBtn setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _downloadMenuBtn;
}



@end
