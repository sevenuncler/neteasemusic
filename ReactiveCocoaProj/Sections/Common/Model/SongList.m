//
//  SongList.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/15.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SongList.h"

@implementation SongList

+ (NSDictionary *)objectClassInArray{
    return @{
             @"tracks" : @"SUTrackItem"
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc" : @"desciption",
             @"lid"  : @"id"
             };
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"description"]) {
        self.desc = value;
    }
}

@end
