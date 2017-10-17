//
//  SUCollectionViewCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUCollectionViewCell.h"

@implementation SUCollectionViewCell

- (void)setMyContentView:(UIView *)myContentView {
    if(_myContentView) {
        [_myContentView removeFromSuperview];
    }
    _myContentView = myContentView;
    [self.contentView addSubview:_myContentView];
}

@end
