//
//  Playerself.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "PlayerView.h"
#import "UIImage+Size.h"
#import "UIView+Layout.h"
#import "Macros.h"

@implementation PlayerPointer
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.pointer];
        [self stop];
    }
    return self;
}

- (void)start {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)stop {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(-M_LOG10E);
    }];
}

- (UIImageView *)pointer {
    if(!_pointer) {
        _pointer = [[UIImageView alloc] initWithFrame:self.frame];
        _pointer.image = [UIImage imageNamed:@"cm2_play_needle_play-ip6"];
    }
    return _pointer;
}

@end

@interface PlayerLongPlaying()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation PlayerLongPlaying
{
//    dispatch_source_t timer;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.container addSubview:self.albumsCover];
        [self addSubview:self.container];
    }
    return self;
}
static CGFloat angle = 0;
- (void)start {
    CGFloat timeInternal = 0.01; //每x时间转动一个弧度
    @weakify(self);
    if(self.myTimer) {
        [self.myTimer invalidate];
    }
    self.myTimer = [NSTimer timerWithTimeInterval:timeInternal repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        self.container.transform = CGAffineTransformMakeRotation(angle);
        angle += M_PI * timeInternal  / 10;  //20s走完一圈
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSDefaultRunLoopMode];
}

- (void)stop {
    if(self.myTimer) {
        [self.myTimer invalidate];
        angle = 0;
        self.container.transform = CGAffineTransformMakeRotation(0);
        
    }
}

- (void)pause {
    if(self.myTimer) {
        [self.myTimer invalidate];
    }
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

@implementation PlayerAssistant
{
     CGFloat assistantButtonWidth;
     CGFloat space;

}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        assistantButtonWidth = 40;
        space = (SCREEN_WIDTH - 4*assistantButtonWidth) / 5;
        
        [self addSubview:self.likeButton];
        [self addSubview:self.downloadButton];
        [self addSubview:self.commentButton];
        [self addSubview:self.profileButton];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
    self.likeButton.size = CGSizeMake(assistantButtonWidth, assistantButtonWidth);
    self.likeButton.centerX = space + assistantButtonWidth/2;
    self.likeButton.centerY = self.size.height / 2;
    
    self.downloadButton.size = CGSizeMake(assistantButtonWidth, assistantButtonWidth);
    self.downloadButton.centerX = self.likeButton.right + space + assistantButtonWidth/2;
    self.downloadButton.centerY = self.size.height / 2;
    
    self.commentButton.size = CGSizeMake(assistantButtonWidth, assistantButtonWidth);
    self.commentButton.centerX = self.downloadButton.right + space + assistantButtonWidth/2;
    self.commentButton.centerY = self.size.height / 2;
    
    self.profileButton.size = CGSizeMake(assistantButtonWidth, assistantButtonWidth);
    self.profileButton.centerX = self.commentButton.right + space + assistantButtonWidth/2;
    self.profileButton.centerY = self.size.height / 2;
}

- (UIButton *)likeButton {
    if(!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage:[UIImage imageNamed:@"cm2_play_icn_love_prs"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"cm2_play_icn_loved"] forState:UIControlStateSelected];
    }
    return _likeButton;
}

- (UIButton *)downloadButton {
    if(!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setImage:[UIImage imageNamed:@"cm2_play_icn_dld_prs"] forState:UIControlStateNormal];
        [_downloadButton setImage:[UIImage imageNamed:@"cm2_play_icn_dld_prs"] forState:UIControlStateSelected];
    }
    return _downloadButton;
}

- (UIButton *)commentButton {
    if(!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"cm2_play_icn_cmt_num_prs"] forState:UIControlStateNormal];
        [_commentButton setImage:[UIImage imageNamed:@"cm2_play_icn_cmt_num_prs"] forState:UIControlStateSelected];
        
    }
    return _commentButton;
}

- (UIButton *)profileButton {
    if(!_profileButton) {
        _profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_profileButton setImage:[UIImage imageNamed:@"cm2_play_icn_more_prs"] forState:UIControlStateNormal];
        [_profileButton setImage:[UIImage imageNamed:@"cm2_play_icn_more_prs"] forState:UIControlStateSelected];
        
    }
    return _profileButton;
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
    CGFloat timeWidth = 65;
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
        _currentTime.textAlignment = NSTextAlignmentCenter;
        _currentTime.text = @"00:00";
    }
    return _currentTime;
}
- (UILabel *)totalTime {
    if(!_totalTime) {
        _totalTime = [UILabel new];
        _totalTime.font = [UIFont systemFontOfSize:9];
        _totalTime.textColor = [UIColor whiteColor];
        _totalTime.textAlignment = NSTextAlignmentCenter;
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
        _progressSlider.thumbTintColor = [UIColor redColor];
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

- (void)onPlayAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (void)onPreAction:(UIButton *)sender {
    _playStatus = PlayerStatusPre;
}
- (void)onNextAction:(UIButton *)sender {
    _playStatus = PlayerStatusNext;
}

- (UIButton *)playOrderButton {
    if(!_playOrderButton) {
        _playOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playOrderButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playOrderButton setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateNormal];
        [_playOrderButton setImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateSelected];
    }
    return _playOrderButton;
}

- (UIButton *)playPreButton {
    if(!_playPreButton) {
        _playPreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playPreButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playPreButton setImage:[UIImage imageNamed:@"cm2_play_btn_prev_prs"] forState:UIControlStateNormal];
        [_playPreButton setImage:[UIImage imageNamed:@"cm2_play_btn_prev_prs"] forState:UIControlStateSelected];
        [_playPreButton addTarget:self action:@selector(onPreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playPreButton;
}

- (UIButton *)playNextButton {
    if(!_playNextButton) {
        _playNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playNextButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playNextButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_next_prs"] forState:UIControlStateNormal];
        [_playNextButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_next_prs"] forState:UIControlStateSelected];
        [_playNextButton addTarget:self action:@selector(onNextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playNextButton;
}

- (UIButton *)playButton {
    if(!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.size = CGSizeMake(buttonWidth+15, buttonWidth+15);
        [_playButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_play_prs"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"cm2_runfm_btn_pause"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(onPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIButton *)playListButton {
    if(!_playListButton) {
        _playListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playListButton.size = CGSizeMake(buttonWidth, buttonWidth);
        [_playListButton setImage:[UIImage imageNamed:@"cm2_icn_list_prs"] forState:UIControlStateNormal];
        [_playListButton setImage:[UIImage imageNamed:@"cm2_icn_list_prs"] forState:UIControlStateSelected];
    }
    return _playListButton;
}



@end
@interface PlayerView()
@property (nonatomic, strong) PlayerLongPlaying *playerLongPlaying;
@property (nonatomic, strong) PlayerMenu        *playerMenu;
@property (nonatomic, strong) PlayerProgress    *playerProgress;
@property (nonatomic, strong) PlayerAssistant   *playerAssistan;
@property (nonatomic, strong) PlayerPointer     *playerPointer;
@end

@implementation PlayerView
@synthesize backgroudView = _backgroudView;
@synthesize maskView      = _maskView;


- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.backgroudView];
        [self addSubview:self.maskView];
        [self addSubview:self.playerLongPlaying];
        [self addSubview:self.playerMenu];
        [self addSubview:self.playerProgress];
        [self addSubview:self.playerAssistan];
        [self addSubview:self.playerPointer];
        UITextField *text = [UITextField new];
        [text.rac_textSignal subscribeNext:^(id x) {
            
        }];
    }
    return self;
}

- (void)startPlay {
    self.playerMenu.playButton.selected = YES;
    [self.playerPointer start];
    [self.playerLongPlaying start];
}

- (void)stopPlay {
        [self.playerPointer stop];
        [self.playerLongPlaying stop];
        self.playerMenu.playButton.selected = NO;
}

- (void)pausePlay {
    [self.playerPointer stop];
    [self.playerLongPlaying pause];
    self.playerMenu.playButton.selected = NO;
}

- (void)seekToPlay:(NSTimeInterval)time {
    
}

#pragma mark - Getter & Setter

- (RACSignal *)actionSignal {
    @weakify(self);
    return [[[RACSignal
             defer:^RACSignal *{
                 @strongify(self);
                 return [RACSignal return:self.playerMenu.playButton];
             }]
            concat:[self.playerMenu.playButton rac_signalForControlEvents:UIControlEventTouchUpInside]]
            map:^id(UIButton *value) {
                return value;
            }];
}

- (RACSignal *)preAndNextSignal {
    @weakify(self);
    return [[[RACSignal defer:^RACSignal *{
                return [RACSignal return:@(0)];
            }]
             concat:[self.playerMenu.playNextButton rac_signalForControlEvents:UIControlEventTouchUpInside]]
             map:^id(id value) {
                 @strongify(self);
                 if([self.playerMenu.playNextButton isEqual:value]) {
                     return @(1);
                 }else if([self.playerMenu.playPreButton isEqual:value]) {
                     return @(-1);
                 }
                 return @(0);
            }];
}

- (RACSignal *)seekSignal {
    return [[self.playerProgress.progressSlider rac_signalForControlEvents:UIControlEventValueChanged]
            map:^id(UISlider *value) {
                return @(value.value);
            }];
}

- (UIImageView *)backgroudView {
    if(!_backgroudView) {
        _backgroudView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroudView.backgroundColor = [UIColor lightGrayColor];
    }
    return _backgroudView;
}

- (UIImageView *)maskView {
    if(!_maskView) {
        _maskView = [[UIImageView alloc] initWithFrame:self.bounds];
        _maskView.image = [UIImage imageNamed:@"cm2_play_disc_mask-ip6"];
    }
    return _maskView;
}

- (PlayerPointer *)playerPointer {
    if(!_playerPointer) {
        CGFloat width = 111;
        _playerPointer = [[PlayerPointer alloc] initWithFrame:CGRectMake(0, 0, width, width*366/222)];
        _playerPointer.layer.anchorPoint = CGPointMake(0.25, 0.15);
        _playerPointer.centerX = self.size.width / 2;
        _playerPointer.centerY = 60;
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        view.backgroundColor = [UIColor redColor];
//        view.centerX = self.size.width / 2;
//        view.centerY = 60;
//        [self addSubview:view];
    }
    return _playerPointer;
}
- (PlayerLongPlaying *)playerLongPlaying {
    if(!_playerLongPlaying) {
        _playerLongPlaying = [[PlayerLongPlaying alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _playerLongPlaying.centerX = self.centerX;
        _playerLongPlaying.centerY = self.centerY*0.89;
    }
    return _playerLongPlaying;
}
- (PlayerMenu *)playerMenu {
    if(!_playerMenu) {
        _playerMenu = [[PlayerMenu alloc] initWithFrame:CGRectMake(0, 500, self.size.width, 120)];
        _playerMenu.botton = self.botton;
    }
    return _playerMenu;
}
- (PlayerProgress *)playerProgress {
    if(!_playerProgress) {
        _playerProgress = [[PlayerProgress alloc] initWithFrame:CGRectMake(0, 0, self.size.width, 15)];
        _playerProgress.botton = self.playerMenu.top;
    }
    return _playerProgress;
}
- (PlayerAssistant *)playerAssistan {
    if(!_playerAssistan) {
        _playerAssistan = [[PlayerAssistant alloc] initWithFrame:CGRectMake(0, 0, self.size.width, 70)];
        _playerAssistan.botton = self.playerProgress.top;
    }
    return _playerAssistan;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    NSInteger time = (NSInteger)currentTime;
    NSInteger min  = time/60;
    NSInteger sec  = time%60;
    self.playerProgress.currentTime.text = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    self.playerProgress.progressSlider.value = currentTime;
}

- (void)setTotolTime:(NSTimeInterval)totolTime {
    NSInteger time = (NSInteger)totolTime;
    NSInteger min  = time/60;
    NSInteger sec  = time%60;
    self.playerProgress.totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    self.playerProgress.progressSlider.maximumValue = totolTime;
}
@end
