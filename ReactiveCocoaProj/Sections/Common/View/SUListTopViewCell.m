//
//  SUListTopViewCell.m
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUListTopViewCell.h"
#import "SUSongListTopView.h"
#import "Macros.h"

@implementation SUListTopViewCell
@synthesize songListTopView = _songListTopView;



- (SUSongListTopView *)songListTopView {
    if(nil == _songListTopView) {
        _songListTopView = [[SUSongListTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.382f)];
    }
    return _songListTopView;
}

@end
