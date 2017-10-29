//
//  PlayerView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, PlayerStatus) {
    PlayerStatusPre = -1,
    PlayerStatusNext= 1,
};



//磁头
@interface PlayerPointer : UIView
@property (nonatomic, strong) UIImageView *pointer;
- (void)start;
- (void)stop;
@end

//黑胶片
@interface PlayerLongPlaying : UIView
@property (nonatomic, strong) UIImageView *albumsCover;
@property (nonatomic, strong) UIImageView *container;
- (void)start;
- (void)stop;
- (void)pause;
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
@property (nonatomic, assign, readonly) PlayerStatus playStatus;

@end

//播放界面
@interface PlayerView : UIView
@property (nonatomic, strong, readonly) UIImageView        *backgroudView;
@property (nonatomic, strong, readonly) UIImageView        *maskView;
@property (nonatomic, assign)           NSTimeInterval     currentTime;
@property (nonatomic, assign)           NSTimeInterval     totolTime;
@property (nonatomic, strong)           NSURL              *URL;
/** 信号 **/
@property (nonatomic, strong)           RACSignal          *actionSignal;
@property (nonatomic, strong)           RACSignal          *preAndNextSignal;
@property (nonatomic, strong)           RACSignal          *seekSignal;
/** 方法 **/
- (void)startPlay;
- (void)stopPlay;
- (void)pausePlay;
- (void)seekToPlay:(NSTimeInterval)time;
@end
