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
@property (nonatomic, strong) UIImageView *pointer;
@end

//黑胶片
@interface PlayerLongPlaying : UIView
@property (nonatomic, strong) UIImageView *albumsCover;
@property (nonatomic, strong) UIImageView *container;
- (void)start;
- (void)stop;
@end

//辅助功能
@interface PlayerAssistant : UIView
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *profileButton;
@end

//播放进度
@interface PlayerProgress : UIView
@property (nonatomic, strong) UILabel  *currentTime;
@property (nonatomic, strong) UILabel  *totalTime;
@property (nonatomic, strong) UISlider *progressSlider;
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
