//
//  SUArtistsItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface SUArtistsItem : SUItem <NSCopying>
@property(nonatomic,assign) NSInteger albumSize;
@property(nonatomic,copy)   NSArray   *alias;
@property(nonatomic,copy)   NSString  *briefDesc;
@property(nonatomic,copy)   NSString  *aid;
@property(nonatomic,copy)   NSString  *img1v1Id;
@property(nonatomic,copy)   NSString  *img1v1Url;
@property(nonatomic,assign) NSInteger musicSize;
@property(nonatomic,copy)   NSString  *name;
@property(nonatomic,copy)   NSString  *picId;
@property(nonatomic,copy)   NSString  *picUrl;
@property(nonatomic,copy)   NSString  *trans;
@end
