//
//  Layout.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "Layout.h"

@implementation Layout

- (id)copyWithZone:(NSZone *)zone {
    Layout *layout = [Layout allocWithZone:zone];
    layout.frame   = self.frame;
    return layout;
}

@end
