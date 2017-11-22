//
//  VideoViewCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/21.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "VideoViewCell1.h"
#import "Macros.h"
#import "UIView+Layout.h"

@interface VideoViewCell1 ()
@property(nonatomic,strong) UIButton *likeB;
@property(nonatomic,strong) UIButton *commentB;
@property(nonatomic,strong) UIButton *optionB;
@end

@implementation VideoViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.coverIV];
        [self.contentView addSubview:self.avatorB];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.playB];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat padding = 10;
    self.coverIV.size = CGSizeMake(self.size.width, self.size.height*0.75);
    self.coverIV.top  = 0;
    self.coverIV.left = 0;
    
    self.playB.center = self.coverIV.center;
    
    self.avatorB.left = padding;
    self.avatorB.top  = padding;
    
    [self.nameL sizeToFit];
    self.nameL.top = self.coverIV.botton + padding;
    self.nameL.left = padding;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Getter & Setter

- (UIImageView *)coverIV {
    if(!_coverIV) {
        _coverIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.618)];
        _coverIV.image  = [UIImage imageNamed:@"image"];
    }
    return _coverIV;
}

- (UILabel *)nameL {
    if(!_nameL) {
        _nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.618, 0)];
        _nameL.numberOfLines = 0;
        _nameL.text = @"视频名称（未知）";
        _nameL.font = [UIFont systemFontOfSize:14];
    }
    return _nameL;
}

- (UIButton *)avatorB {
    if(!_avatorB) {
        _avatorB = [UIButton buttonWithType:UIButtonTypeCustom];
        [_avatorB setImage:[UIImage imageNamed:@"image"] forState: UIControlStateNormal];
        _avatorB.frame = CGRectMake(0, 0, 30, 30);
        _avatorB.layer.cornerRadius  = 15;
        _avatorB.layer.masksToBounds = YES;
    }
    return _avatorB;
}

- (UIButton *)playB {
    if(!_playB) {
        _playB = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playB setImage:[UIImage imageNamed:@"image"] forState: UIControlStateNormal];
        _playB.frame = CGRectMake(0, 0, 30, 30);
        _playB.layer.cornerRadius = 15;
        _playB.hidden = YES;
    }
    return _playB;
}


@end
