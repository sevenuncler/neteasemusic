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
#import "NetEaseMusic.h"

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
@synthesize songs       = _songs;
@synthesize playList    = _playList;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}
+ (instancetype)sharedInstance {
    static SUPlayerViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self bindData];
    [self addPlayerObserver];
    [self.view addSubview:self.playerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Public

- (void)playAtIndex:(NSIndexPath *)indexPath {
    
}

#pragma mark - Private

- (void)startPlayList {
    NSString *songURLString = [self nextSong];
    [self playSong:songURLString];
}

- (void)playSong:(NSString *)urlString {
    [self.playerView stopPlay];
    if(!urlString) {
        [self.liveplayer pause];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.liveplayer switchContentUrl:[NSURL URLWithString:urlString]];
    });

}

- (NSString *)nextSong {
    switch (_playListOrder) {
        case PlayListOrderLoopOrder:
            _currentIdx = (_currentIdx+1)%self.playList.tracks.count;
            break;
        case PlayListOrderOne:
            break;
        case PlayListOrderShuffle:
            _currentIdx = arc4random()%self.playList.tracks.count;
            break;
        default:
            break;
    }
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSString *urlString;
    [NetEaseMusic songURLWithID:self.playList.tracks[_currentIdx].tid complection:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"请求歌曲地址错误 %@",error);
            dispatch_semaphore_signal(semaphore);
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if(dict) {
            dict = dict[@"data"][0];
            if(![dict[@"url"] isMemberOfClass:[NSNull class]]) {
                urlString = (NSString *)dict[@"url"];
            }else {
                urlString = nil;
            }
        }
        dispatch_semaphore_signal(semaphore);

    }];
    if(dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER) == 0) {
        NSLog(@"歌曲地址请求成功:%@", urlString);
    }else {
        NSLog(@"歌曲地址请求成失败");
    }
    return urlString;
}

- (NSString *)preSong {
    _currentIdx = (_currentIdx+1)%self.playList.tracks.count;
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
    [self.liveplayer play];
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

- (void)setSongs:(NSMutableArray *)songs {
    if(_songs != songs) {
        _songs = songs.mutableCopy;
    }
}

- (void)setPlayList:(SongList *)playList {
    if(_playList != playList) {
        _playList = playList;
        [self.songs removeAllObjects];
        __weak typeof(self) weakSelf = self;
        [_playList.tracks enumerateObjectsUsingBlock:^(SUTrackItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [NetEaseMusic songURLWithID:obj.tid complection:^(NSData *data, NSURLResponse *response, NSError *error) {
                if(error) {
                    NSLog(@"请求歌曲地址错误 %@",error);
                }
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(dict) {
                    dict = dict[@"data"][0];
                }
                [weakSelf.songs addObject:dict[@"url"]];
            }];
        }];
    }
}

- (SongList *)playList {
    if(nil == _playList) {
        _playList = [SongList new];
    }
    return _playList;
}


- (NELivePlayerController *)liveplayer {
    if(!_liveplayer) {
        NSString *urlString = @"http://m10.music.126.net/20171119171942/6e4a84f638dc22ca6ceb0a3a1f5f11c0/ymusic/9593/59ca/56ea/fc92992c2eac7137bf4cc1d7851fe094.mp3";
        _liveplayer = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:urlString] error:nil];
        _liveplayer.view.frame = self.view.bounds;
        _liveplayer.shouldAutoplay = NO;
        [_liveplayer prepareToPlay];
    }
    return _liveplayer;
}

@end
