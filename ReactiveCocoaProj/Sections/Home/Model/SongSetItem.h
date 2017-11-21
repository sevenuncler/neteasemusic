//
//  SongSetItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

typedef NS_ENUM(NSInteger, SongSetType) {
    SongSetTypePrivateFM,
    SongSetTypeDailyRecommend,
    SongSetTypePlayList,
    SongSetTypeRank
};

@interface SongSetItem : SUItem

@property (nonatomic, copy) NSString *coverImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SongSetType songSetType;

@end
