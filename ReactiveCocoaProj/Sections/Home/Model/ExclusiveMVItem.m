//
//  ExclusiveMVItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "ExclusiveMVItem.h"

@implementation ExclusiveMVItem

+ (NSDictionary *)objectClassInArray{
    return @{
             @"artists" : @"SUArtistsItem"
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"eid"  : @"id"
             };
}

@end
