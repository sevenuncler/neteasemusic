//
//  PersonalizedItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "PersonalizedItem.h"

@implementation PersonalizedItem

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"pid" : @"id"
             };
}

@end
