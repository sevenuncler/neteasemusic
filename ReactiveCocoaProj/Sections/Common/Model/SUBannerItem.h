//
//  SUBannerItem.h
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface SUBannerItem : SUItem
@property(nonatomic,assign) NSInteger   targetType;
@property(nonatomic,copy)   NSString    *adid;
@property(nonatomic,copy)   NSString    *titleColor;
@property(nonatomic,copy)   NSString    *encodeId;
@property(nonatomic,copy)   NSString    *targetId;
@property(nonatomic,copy)   NSString    *pic;
@end
