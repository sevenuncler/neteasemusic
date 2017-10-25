//
//  PlayerView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerPointer : UIView

@end

@interface PlayerLongPlaying : UIView

@property (nonatomic, strong) UIImageView *albumsCover;
@property (nonatomic, strong) UIImageView *container;

- (void)start;
- (void)stop;

@end

@interface PlayerView : UIView

@end
