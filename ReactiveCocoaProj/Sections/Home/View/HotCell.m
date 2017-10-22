//
//  HotCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "HotCell.h"

@implementation HotCell
@synthesize coverImageView = _coverImageView;

- (UIImageView *)coverImageView {
    if(!_coverImageView) {
        _coverImageView = [UIImageView new];
    }
    return _coverImageView;
}
@end
