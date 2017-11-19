//
//  SUAlbumItem.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUAlbumItem.h"

@implementation SUAlbumItem

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc" : @"desciption"
             };
}

- (id)copyWithZone:(nullable NSZone *)zone {
    SUAlbumItem *albumItem = [SUAlbumItem allocWithZone:zone];
    return albumItem;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
