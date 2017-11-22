//
//  HeaderView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/31.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "HeaderView.h"
#import "UIView+Layout.h"

@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftView];
        [self addSubview:self.titleLable];
        [self addSubview:self.moreButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftView.centerY = self.size.height/2;
    
    [self.titleLable sizeToFit];
    NSLog(@"%@", self.titleLable);
    self.titleLable.left = self.leftView.right+15;
    self.titleLable.centerY = self.size.height/2;
    
    self.moreButton.left = self.titleLable.right;
    self.moreButton.centerY = self.titleLable.centerY;
}

- (UIView *)leftView {
    if(!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor redColor];
        _leftView.frame = CGRectMake(0, 0, 2, self.size.height/3);
    }
    return _leftView;
}

- (UILabel *)titleLable {
    if(!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.text = @"推荐歌单";
        _titleLable.size = CGSizeMake(250, 0);
        [_titleLable sizeToFit];
        _titleLable.font = [UIFont systemFontOfSize:16];
    }
    return _titleLable;
}

- (UIButton *)moreButton {
    if(!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"cm2_list_icn_arr_fold"] forState:UIControlStateNormal];
        _moreButton.size = CGSizeMake(self.size.height,self.size.height);
    }
    return _moreButton;
}
@end
