//
//  SongSetView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SongSetView.h"
#import "UIView+Layout.h"


@implementation SongSetView
@synthesize imageView = _imageView;
@synthesize label     = _label;

+ (NSString *)reuseID {
    return @"songSetView";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label sizeToFit];
    self.label.centerX = self.imageView.centerX;
    self.label.size    = self.label.size;
}
#pragma mark - Getter & Setter

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView      = [UIImageView new];
        _imageView.size = CGSizeMake(self.size.width-20, self.size.width-20);
        _imageView.centerX = self.size.width  / 2.f;
        _imageView.top = 0;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)label {
    if(!_label) {
        _label = [UILabel new];
        _label.size = CGSizeMake(self.size.width, 15);
        _label.centerX = self.imageView.centerX;
        _label.top     = self.imageView.botton + 5;
        _label.font    = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_label];
    }
    return _label;
}

@end
