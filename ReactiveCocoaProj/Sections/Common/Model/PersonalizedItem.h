//
//  PersonalizedItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface PersonalizedItem : SUItem
@property(nonatomic,copy) NSString *pid;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *copywriter;
@property(nonatomic,copy) NSString *picUrl;
@property(nonatomic,assign) CGFloat playCount;
@property(nonatomic,assign) NSInteger trackCount;
//"id":113511978,"type":0,"name":"北欧后摇氛围,如梦似幻的落寞之旅","copywriter":"编辑推荐：来自北欧的清冷声音，如极光般梦幻","picUrl":"http://p1.music.126.net/rhbxWUndbuKfZme4IiYplw==/3428277255764485.jpg","canDislike":false,"playCount":3141834.8,"trackCount":50,"highQuality":true,"alg":"featured
@end
