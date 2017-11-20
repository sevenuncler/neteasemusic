//
//  SUItem.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Layout.h"

@interface SUItem : NSObject <NSCopying>

@property (nonatomic, assign) CGFloat         itemHeight;
@property (nonatomic, strong) NSMutableArray  *subItems;
@property (nonatomic, strong) Layout          *layout;
@property (nonatomic, assign, getter=isHidden) BOOL hidden;

@end
