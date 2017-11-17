//
//  SUTrackItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"
@class SUAlbumItem;
@class SUArtistsItem;
@class SUMusicItem;
@interface SUTrackItem : SUItem
@property(nonatomic, copy) SUAlbumItem *album;
@property(nonatomic, copy) NSArray     *alias;
@property(nonatomic, copy) NSArray<SUArtistsItem *> *artists;
@property(nonatomic, copy) SUMusicItem *bMusic;
@property(nonatomic, copy) NSString    *commentThreadId;
@property(nonatomic, copy) NSString    *tid;
@property(nonatomic, copy) NSString    *mp3Url;
@property(nonatomic, copy) NSString    *mvid;
@property(nonatomic, copy) NSString    *name;
@property(nonatomic, assign) NSInteger playedNum;
@end
