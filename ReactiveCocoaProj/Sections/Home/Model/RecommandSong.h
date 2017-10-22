//
//  RecommandSong.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@class Song;
@interface RecommandSong : SUItem

@property (nonatomic, copy)   NSString               *coverPath;
@property (nonatomic, copy)   NSString               *title;
@property (nonatomic, copy)   NSString               *listenedCount;
@property (nonatomic, strong) NSMutableArray<Song *> *songs;

@end
