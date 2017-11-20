//
//  SUUserItem.m
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUUserItem.h"

@implementation SUUserItem

- (id)copyWithZone:(NSZone *)zone {
    SUUserItem *item = [SUUserItem allocWithZone:zone];
    item.defaultAvatar  =   self.defaultAvatar;
    item.province       =   self.province;
    item.authStatus     =   self.authStatus;
    item.followed       =   self.followed;
    item.avatarUrl      =   self.avatarUrl.copy;
    item.accountStatus  =   self.accountStatus;
    item.gender         =   self.gender;
    item.city           =   self.city;
    item.birthday       =   self.birthday;
    item.userId         =   self.userId.copy;
    item.userType       =   self.userType;
    item.nickname       =   self.nickname;
    item.signature      =   self.signature.copy;
    item.desc           =   self.desc.copy;
    item.detailDescription       =   self.detailDescription.copy;
    item.avatarImgId    =   self.avatarImgId;
    item.backgroundImgId         =   self.backgroundImgId;
    item.backgroundUrl           =   self.backgroundUrl.copy;
    item.authority               =   self.authority;
    item.mutual         =   self.mutual;
    item.expertTags     =   self.expertTags.copy;
    item.experts        =   self.experts.copy;
    item.djStatus       =   self.djStatus;
    item.vipType        =   self.vipType;
    item.remarkName              =   self.remarkName.copy;
    item.avatarImgIdStr          =   self.avatarImgIdStr.copy;
    item.backgroundImgIdStr      =   self.backgroundImgIdStr.copy;
    
    return item;
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc" : @"desciption"
             };
}

@end
