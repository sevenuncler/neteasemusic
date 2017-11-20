//
//  SUListTopViewCell.h
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUTableViewCell.h"

@class SUSongListTopView;

@interface SUListTopViewCell : SUTableViewCell
@property(nonatomic,strong,readonly) SUSongListTopView  *songListTopView;
@end
