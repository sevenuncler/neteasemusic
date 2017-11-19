//
//  SUMusicItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUMusicItem.h"

@implementation SUMusicItem

- (id)copyWithZone:(nullable NSZone *)zone {
    SUMusicItem *musicItem = [SUMusicItem allocWithZone:zone];
    musicItem.bitrate   =   self.bitrate;
    musicItem.dfsId     =   self.dfsId;
    musicItem.extension =   self.extension.copy;
    musicItem.mid       =   self.mid;
    musicItem.name      =   self.name.copy;
    musicItem.playTime  =   self.playTime;
    musicItem.size      =   self.size;
    musicItem.sr        =   self.sr;
    musicItem.volumeDelta   =   self.volumeDelta;
    return musicItem;
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"mid"  : @"id"
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"]) {
        self.mid = value;
    }
}

@end
