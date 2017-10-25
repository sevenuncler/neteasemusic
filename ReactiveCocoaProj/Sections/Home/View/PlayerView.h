//
//  PlayerView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

//磁头
@interface PlayerPointer : UIView
@end

//黑胶片
@interface PlayerLongPlaying : UIView
@property (nonatomic, strong) UIImageView *albumsCover;
@property (nonatomic, strong) UIImageView *container;
- (void)start;
- (void)stop;
@end

//播放菜单
@interface PlayerMenu : UIView
@property (nonatomic, strong) UIButton *playOrderButton;
@property (nonatomic, strong) UIButton *playPreButton;
@property (nonatomic, strong) UIButton *playNextButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *playListButton;
@end

//播放界面
@interface PlayerView : UIView
@property (nonatomic, strong, readonly) UIImageView *backgroudView;
@property (nonatomic, strong, readonly) UIImageView *maskView;
@end
