//
//  MyMusicHeader.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/3.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "MyMusicHeaderView.h"
#import "UIView+Layout.h"

@implementation MyMusicHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.leftButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftButton.size = CGSizeMake(self.size.height-15, self.size.height-15);
    self.leftButton.left = 5;
    self.leftButton.centerY = self.size.height/2;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.left = self.leftButton.right + 5;
    self.titleLabel.centerY = self.leftButton.centerY;
}

- (UIButton *)leftButton {
    if(!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"cm2_list_icn_arr_fold"] forState:UIControlStateSelected];
        [_leftButton setImage:[UIImage imageNamed:@"cm2_edit_arr"] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.text = @"网易云音乐";
    }
    return _titleLabel;
}

@end
