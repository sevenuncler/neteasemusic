//
//  SUItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@implementation SUItem

- (Layout *)layout {
    if(!_layout) {
        _layout = [Layout new];
    }
    return _layout;
}

@end
