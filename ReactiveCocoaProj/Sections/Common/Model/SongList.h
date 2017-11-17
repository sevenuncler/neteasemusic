//
//  SongList.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/15.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"
@class SUAlbumItem;
@class SUTrackItem;
@interface SongList : SUItem
@property(nonatomic, copy) NSString *coverImgUrl;
@property(nonatomic, assign) long createTime;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger playCount;
@property(nonatomic, copy) NSArray<SUTrackItem *>  *tracks;
@end
