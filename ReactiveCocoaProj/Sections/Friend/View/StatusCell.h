//
//  StatusCell.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/5.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusView.h"
#import "SUTableViewCell.h"

@interface StatusCell : SUTableViewCell
@end

@interface SongViewCell : StatusCell
@property(nonatomic, strong) SongStatusView *songStatusView;
@end

@interface VideoViewCell : StatusCell
@property(nonatomic, strong) VideoStatusView *videoStatusView;
@end

