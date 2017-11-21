//
//  ExclusiveMVItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"
#import "SUArtistsItem.h"

@interface ExclusiveMVItem : SUItem
@property(nonatomic,copy) NSString *eid;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *briefDesc;
@property(nonatomic,copy) NSString *artistId;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *artistName;
@property(nonatomic,assign) NSInteger playCount;
@property(nonatomic,copy) NSArray<SUArtistsItem *>   *artists;
@end
