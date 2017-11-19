//
//  SUArtistsItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUArtistsItem.h"

@implementation SUArtistsItem

- (id)copyWithZone:(NSZone *)zone {
    SUArtistsItem *artstItem = [SUArtistsItem allocWithZone:zone];
    artstItem.albumSize = self.albumSize;
    artstItem.alias     = self.alias.copy;
    artstItem.briefDesc = self.briefDesc.copy;
    artstItem.aid       = self.aid.copy;
    artstItem.img1v1Id  = self.img1v1Id.copy;
    artstItem.img1v1Url = self.img1v1Url.copy;
    artstItem.musicSize = self.musicSize;
    artstItem.name      = self.name.copy;
    artstItem.picId     = self.picId.copy;
    artstItem.picUrl    = self.picUrl.copy;
    artstItem.trans     = self.trans.copy;
    return artstItem;
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"aid"  : @"id"
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"]) {
        self.aid = value;
    }
}

@end
