//
//  SUGoHorseLampCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/5.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUGoHorseLampCell.h"

@implementation SUGoHorseLampCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.myImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (UIImageView *)myImageView {
    if(!_myImageView) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _myImageView;
}

@end
