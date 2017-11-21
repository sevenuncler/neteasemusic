//
//  NewSongItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/21.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"
#import "SUTrackItem.h"

@interface NewSongItem : SUItem
@property(nonatomic,copy) NSString *nid;
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *copywriter;
@property(nonatomic,copy) NSString *picUrl;
@property(nonatomic,assign) BOOL canDislike;
@property(nonatomic,strong) SUTrackItem *song;

@end
