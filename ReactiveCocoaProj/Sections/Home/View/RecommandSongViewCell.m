//
//  RecommandSongViewCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "RecommandSongViewCell.h"
#import "UIView+Layout.h"

@implementation RecommandSongViewCell

@synthesize coverImageView = _coverImageView;
@synthesize titleLabel     = _titleLabel;
@synthesize listenedLabel  = _listenedLabel;
@synthesize subTitleLabel  = _subTitleLabel;


+ (NSString *)description {
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.coverImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.listenedLabel];
        [self addSubview:self.subTitleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.coverImageView.frame = CGRectMake(0, 0, self.size.width, self.size.width);
    
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(self.size.width, 0)];
    self.titleLabel.top       = self.coverImageView.botton+5;
    self.titleLabel.left      = 5;
    self.titleLabel.size      = size;
    
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.top    = self.titleLabel.botton;
    self.subTitleLabel.left   = self.titleLabel.left;
    
    [self.listenedLabel sizeToFit];
    self.listenedLabel.top    = 0;
    self.listenedLabel.right  = 0;

}



- (UIImageView *)coverImageView {
    if(!_coverImageView) {
        _coverImageView = [UIImageView  new];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if(!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.numberOfLines = 1;
        _subTitleLabel.font = [UIFont systemFontOfSize:11];
    }
    return _subTitleLabel;
}

- (UILabel *)listenedLabel {
    if(!_listenedLabel) {
        _listenedLabel = [UILabel new];
        _listenedLabel.numberOfLines = 1;
    }
    return _listenedLabel;
}

@end
