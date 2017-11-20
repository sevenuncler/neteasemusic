//
//  SUItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@implementation SUItem

- (id)copyWithZone:(nullable NSZone *)zone {
    SUItem *item = [SUItem allocWithZone:zone];
    item.itemHeight = self.itemHeight;
    item.subItems   = self.subItems.mutableCopy;
    item.layout     = self.layout.copy;
    item.hidden     = self.isHidden;
    return item;
}

- (Layout *)layout {
    if(!_layout) {
        _layout = [Layout new];
    }
    return _layout;
}

@end
