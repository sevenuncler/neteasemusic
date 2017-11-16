//
//  SongList.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/15.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SongList.h"

@implementation SongList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"description"]) {
        self.desc = value;
    }
    NSLog(@"%@ %@", value, key);
}

@end
