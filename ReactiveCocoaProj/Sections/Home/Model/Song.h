//
//  Song.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, copy) NSString *songCoverPath;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, copy) NSString *title;

@end
