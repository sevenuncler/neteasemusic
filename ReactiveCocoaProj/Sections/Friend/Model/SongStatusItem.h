//
//  SongStatusItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/5.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "StatusItem.h"

@interface SongStatusItem : StatusItem
@property (nonatomic, strong) SUItem *song;
@property (nonatomic, strong) NSMutableArray *pics;
@end
