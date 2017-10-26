//
//  PlayerView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "PlayerView.h"
#import "UIImage+Size.h"
#import "UIView+Layout.h"

@implementation PlayerLongPlaying
{
    dispatch_source_t timer;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.container addSubview:self.albumsCover];
        [self addSubview:self.container];
    }
    return self;
}

- (void)start {
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());

    CGFloat timeInternal = 0.01; //每x时间转动一个弧度
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, timeInternal * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    static CGFloat angle = M_PI_4/2;
    dispatch_source_set_event_handler(timer, ^{
        
        self.container.transform = CGAffineTransformMakeRotation(angle);
        angle += M_PI * timeInternal  / 10;  //20s走完一圈
    });
    dispatch_resume(timer);
}

- (void)stop {
    dispatch_suspend(timer);
}

- (UIImageView *)albumsCover {
    if(!_albumsCover) {
        _albumsCover = [[UIImageView alloc] init];
        CGFloat radium = self.container.size.width*0.63;
        _albumsCover.frame = CGRectMake(0, 0, radium, radium);
        _albumsCover.image = [UIImage imageNamed:@"LaunchImage"].round(CGSizeMake(radium, radium),radium/2);
        _albumsCover.center = self.container.center;
    }
    return _albumsCover;
}

- (UIImageView *)container {
    if(!_container) {
        _container = [[UIImageView alloc] initWithFrame:self.bounds];
        _container.image = [UIImage imageNamed:@"cm2_play_disc"];
    }
    return _container;
}

@end

@implementation PlayerProgress
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.currentTime];
        [self addSubview:self.totalTime];
        [self addSubview:self.progressSlider];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat timeWidth = 60;
    self.progressSlider.size = CGSizeMake(self.size.width - timeWidth*2, 10);
    self.progressSlider.centerX = self.size.width/2;
    self.progressSlider.centerY = self.size.height/2;
    
    [self.currentTime sizeToFit];
    self.currentTime.centerX = timeWidth/2;
    self.currentTime.centerY = self.progressSlider.centerY;
    
    [self.totalTime sizeToFit];
    self.totalTime.centerX = self.size.width - timeWidth/2;
    self.totalTime.centerY = self.progressSlider.centerY;
}

- (UILabel *)currentTime {
    if(!_currentTime) {
        _currentTime  = [[UILabel alloc] init];
        _currentTime.font = [UIFont systemFontOfSize:9];
        _currentTime.textColor = [UIColor whiteColor];
        _currentTime.text = @"00:00";
    }
    return _currentTime;
}
- (UILabel *)totalTime {
    if(!_totalTime) {
        _totalTime = [UILabel new];
        _totalTime.font = [UIFont systemFontOfSize:9];
        _totalTime.textColor = [UIColor whiteColor];
        _totalTime.text = @"04:24";
    }
    return _totalTime;
}
- (UISlider *)progressSlider {
    if(!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        _progressSlider.minimumValue = 0;
        _progressSlider.maximumValue = 5;
        _progressSlider.minimumTrackTintColor = [UIColor redColor];
        _progressSlider.maximumTrackTintColor = [UIColor whiteColor];
        _progressSlider.thumbTintColor = [UIColor blackColor];
    }
    return _progressSlider;
}
@end

@implementation PlayerMenu
static CGFloat buttonWidth = 45;

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.playOrderButton];
        [self addSubview:self.playPreButton];
        [self addSubview:self.playButton];
        [self addSubview:self.playNextButton];
        [self addSubview:self.playListButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 75;
    self.playButton.centerX = self.centerX;
    self.playButton.centerY = self.size.height/2;
    
    self.playPreButton.centerX = self.playButton.centerX - space;
    self.playPreButton.centerY = self.playButton.centerY;
    
    self.playOrderButton.centerX = self.playButton.centerX - space*2;
    self.playOrderButton.centerY = self.playButton.centerY;
    
    self.playNextButton.centerX = self.playButton.centerX + space;
    self.playNextButton.centerY = self.playButton.centerY;
    
    self.playListButton.centerX = self.playButton.centerX + space*2;
    self.playListButton.centerY = self.playButton.centerY;
}

- (UIButton *)playOrderButton {
    if(!_playOrderButton) {
        _playOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playOrderButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playOrderButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_loop"] forState:UIControlStateNormal];
        [_playOrderButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_shuffle"] forState:UIControlStateSelected];
    }
    return _playOrderButton;
}

- (UIButton *)playPreButton {
    if(!_playPreButton) {
        _playPreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playPreButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playPreButton setImage:[UIImage imageNamed:@"cm2_play_btn_prev"] forState:UIControlStateNormal];
        [_playPreButton setImage:[UIImage imageNamed:@"cm2_play_btn_prev"] forState:UIControlStateSelected];
    }
    return _playPreButton;
}

- (UIButton *)playNextButton {
    if(!_playNextButton) {
        _playNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playNextButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playNextButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_next_dis"] forState:UIControlStateNormal];
        [_playNextButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_next_dis"] forState:UIControlStateSelected];
    }
    return _playNextButton;
}

- (UIButton *)playButton {
    if(!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.size = CGSizeMake(buttonWidth+15, buttonWidth+15);
        [_playButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_play_prs"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_pause"] forState:UIControlStateSelected];
    }
    return _playButton;
}

- (UIButton *)playListButton {
    if(!_playListButton) {
        _playListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playListButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playListButton setImage:[UIImage imageNamed:@"cm2_play_btn_src"] forState:UIControlStateNormal];
        [_playListButton setImage:[UIImage imageNamed:@"cm2_play_btn_src"] forState:UIControlStateSelected];
    }
    return _playListButton;
}



@end

@implementation PlayerView
@synthesize backgroudView = _backgroudView;
@synthesize maskView      = _maskView;

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.backgroudView];
        [self addSubview:self.maskView];
    }
    return self;
}

- (UIImageView *)backgroudView {
    if(!_backgroudView) {
        _backgroudView = [[UIImageView alloc] initWithFrame:self.bounds];
//        _backgroudView.image = [UIImage imageNamed:@"750_1334.jpg"];
        _backgroudView.backgroundColor = [UIColor blackColor];
    }
    return _backgroudView;
}

- (UIImageView *)maskView {
    if(!_maskView) {
        _maskView = [[UIImageView alloc] initWithFrame:self.bounds];
        _maskView.image = [UIImage imageNamed:@"cm2_play_disc_mask"];
    }
    return _maskView;
}

@end
