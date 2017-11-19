//
//  SUTrackItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUTrackItem.h"
#import "SUArtistsItem.h"
#import "SUMusicItem.h"
#import "SUAlbumItem.h"

@implementation SUTrackItem

+ (NSDictionary *)objectClassInArray{
    return @{
             @"artists" : @"SUArtistsItem"
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc" : @"desciption",
             @"tid"  : @"id"
             };
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"]) {
        self.tid = value;
    }
}
@end
