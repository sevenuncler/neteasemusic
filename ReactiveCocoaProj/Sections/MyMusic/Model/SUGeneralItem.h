//
//  SUGeneralItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/2.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface SUGeneralItem : SUItem
@property (nonatomic, strong) SUItem *header;
@property (nonatomic, strong) NSMutableArray<SUItem *> *contentItems;
@property (nonatomic, strong) SUItem *footer;
@end
