//
//  SUGeneralItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/2.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUGeneralItem.h"

@implementation SUGeneralItem
- (NSMutableArray<SUItem *> *)contentItems {
    if(!_contentItems) {
        _contentItems = [NSMutableArray array];
    }
    return _contentItems;
}
@end
