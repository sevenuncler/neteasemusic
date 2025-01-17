//
//  SUPlayerViewController.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongList.h"

@interface SUPlayerViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *songs;
@property (nonatomic, weak)   UITabBarController *tabBarController;
@property (nonatomic, strong) SongList *playList;
+ (instancetype)sharedInstance;
- (void)startPlayList;
- (void)playAtIndex:(NSIndexPath *)indexPath;
@end
