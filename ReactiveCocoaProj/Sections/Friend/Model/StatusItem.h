//
//  StatusItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface StatusItem : SUItem
@property (nonatomic, strong)   SUItem *publisher;
@property (nonatomic, strong)   NSDate *publishedTime;
@property (nonatomic, copy)     NSString *publishText;
@property (nonatomic, copy)     NSString *publishTag;
@property (nonatomic, strong)   NSMutableArray *liked;
@property (nonatomic, strong)   NSMutableArray *comments;
@property (nonatomic, copy)     NSString *repeatCount;
@end



@interface VideoStatusItem : StatusItem
@property (nonatomic, strong) SUItem *video;
@end
