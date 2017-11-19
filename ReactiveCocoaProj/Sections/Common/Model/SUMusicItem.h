//
//  SUMusicItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface SUMusicItem : SUItem <NSCopying>
@property(nonatomic,assign) NSInteger bitrate;
@property(nonatomic,assign) NSInteger dfsId;
@property(nonatomic,copy)   NSString  *extension;
@property(nonatomic,copy)   NSString  *mid;
@property(nonatomic,copy)   NSString  *name;
@property(nonatomic,assign) NSInteger playTime;
@property(nonatomic,assign) NSInteger size;
@property(nonatomic,assign) NSInteger sr;
@property(nonatomic,assign) CGFloat   volumeDelta;
@end
