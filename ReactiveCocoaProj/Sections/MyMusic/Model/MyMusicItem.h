//
//  MyMusicItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/3.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface MyMusicItem : SUItem
@property (nonatomic, strong) NSString *fileURLString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *subTitleString;
@property (nonatomic, strong) NSString *countString;
@end
