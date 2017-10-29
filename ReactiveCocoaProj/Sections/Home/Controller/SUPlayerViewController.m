//
//  SUPlayerViewController.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUPlayerViewController.h"
#import "PlayerView.h"
#import "UIView+Layout.h"
#import "Macros.h"
#import <AVKit/AVKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
        #import "NSObject+RACPropertySubscribing.h"
#import "SUAdvancePlayer.h"
#import "NELivePlayer.h"
#import "NELivePlayerController.h"

extern void _objc_autoreleasePoolPrint();

typedef NS_ENUM(NSUInteger, PlayListOrder){
    PlayListOrderLoopOrder = 0,
    PlayListOrderOne       = 1,
    PlayListOrderShuffle   = 2,
    PlayListOrderPre       = 3
};


@interface SUPlayerViewController ()
{
    PlayListOrder _playListOrder;
    NSInteger     _currentIdx;
}
@property (nonatomic, strong) NELivePlayerController  *liveplayer;
@property (nonatomic, strong) PlayerView        *playerView;
@property (nonatomic, strong) NSTimer           *uiTimer;

@end

@implementation SUPlayerViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self bindData];
    [self addPlayerObserver];
    [self.view addSubview:self.playerView];
    
//    [self startPlayList];
}
#pragma mark - Private

- (void)startPlayList {
    NSString *songURLString = [self nextSong];
    [self playSong:songURLString];
}

- (void)playSong:(NSString *)urlString {
    [self.playerView stopPlay];
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @strongify(self);
        [self.liveplayer switchContentUrl:[NSURL URLWithString:urlString]];
    });

}

- (NSString *)nextSong {
    switch (_playListOrder) {
        case PlayListOrderLoopOrder:
            _currentIdx = (_currentIdx+1)%self.songs.count;
            break;
        case PlayListOrderOne:
            break;
        case PlayListOrderShuffle:
            _currentIdx = arc4random()%self.songs.count;
            break;
        default:
            break;
    }
    return [self.songs objectAtIndex:_currentIdx];
}

- (NSString *)preSong {
    _currentIdx = (_currentIdx+1)%self.songs.count;
    return [self.songs objectAtIndex:_currentIdx];
}

- (void)bindData {
    @weakify(self);
    [self.playerView.actionSignal subscribeNext:^(UIButton *x) {
        @strongify(self);
        if(x.isSelected) {
//            self.liveplayer.shouldAutoplay = YES;
            [self.liveplayer play];
            [self.playerView startPlay];
        }else {
            [self.liveplayer pause];
            [self.playerView pausePlay];
        }
    }];
    
    [self.playerView.preAndNextSignal subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if([x integerValue] == -1) {
            [self playSong:[self preSong]];
        }else if([x integerValue] == 1) {
            [self playSong:[self nextSong]];
        }
    }];
    
    [[self.liveplayer rac_valuesAndChangesForKeyPath:@"duration" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [[self.liveplayer rac_valuesAndChangesForKeyPath:@"currentPlaybackTime" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [self.playerView.seekSignal subscribeNext:^(NSNumber *x) {
        float time = [x floatValue];
        self.liveplayer.currentPlaybackTime = time;
    }];
}

- (void)NELivePlayerDidPreparedToPlay:(id)sender {
    NSLog(@"%s", __func__);
}

- (void)NeLivePlayerloadStateChanged:(id)sender {
    NSLog(@"%s", __func__);
}

- (void)NELivePlayerPlayBackFinished:(id)sender {
    NSLog(@"%s", __func__);
    [self startPlayList];
}

- (void)NELivePlayerFirstVideoDisplayed:(id)sender {
    NSLog(@"%s", __func__);
}

- (void)NELivePlayerVideoParseError:(id)sender {
    NSLog(@"%s", __func__);
}

- (void)NELivePlayerFirstAudioDisplayed:(id)sender {
    self.playerView.totolTime = self.liveplayer.duration;
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.playerView startPlay];
        self.playerView.totolTime = self.liveplayer.duration;
        if(self.uiTimer){
            [self.uiTimer invalidate];
        }
        self.uiTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.playerView.currentTime = self.liveplayer.currentPlaybackTime;
        }];
    });
}


- (void)NELivePlayerReleaseSuccess:(id)sender {
    
}


- (void)addPlayerObserver {
    // 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_liveplayer];
    
    // 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_liveplayer];
    
    // 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_liveplayer];
    
    // 第一帧视频图像显示时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_liveplayer];
    
    // 第一帧音频播放时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_liveplayer];
    
    
    // 资源释放成功后触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:_liveplayer];
    
    // 视频码流解析失败时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerVideoParseError:)
                                                 name:NELivePlayerVideoParseErrorNotification
                                               object:_liveplayer];
}


#pragma mark - Getter & Setter

- (PlayerView *)playerView {
    if(!_playerView) {
        _playerView = [[PlayerView alloc] initWithFrame:self.view.bounds];
    }
    return _playerView;
}

- (NSMutableArray *)songs {
    if(!_songs) {
        _songs = [NSMutableArray new];
        [_songs addObject:@"http://mr1.doubanio.com/775f3815dc744976a864647b10f38e27/0/fm/song/p1849610_128k.mp4"];
        [_songs addObject:@"http://mr3.doubanio.com/4b98fb41d70e68cde60b9e028a39cf00/1/fm/song/p42329_128k.mp4"];
        [_songs addObject:@"http://mr3.doubanio.com/d7a3b9b63297acca60682f7b9523549d/2/fm/song/p1805284_128k.mp3"];
    }
    return _songs;
}

- (NELivePlayerController *)liveplayer {
    if(!_liveplayer) {
        NSString *urlString = [self.songs objectAtIndex:_currentIdx];
        _liveplayer = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:urlString] error:nil];
        _liveplayer.view.frame = self.view.bounds;
        _liveplayer.shouldAutoplay = NO;
        [_liveplayer prepareToPlay];
    }
    return _liveplayer;
}

@end
