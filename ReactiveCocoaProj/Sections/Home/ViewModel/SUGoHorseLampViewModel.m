//
//  SUGoHorseLampViewModel.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUGoHorseLampViewModel.h"
#import "SUGoHorseLampCell.h"
#import "SUImageManager.h"
#import "Macros.h"


@interface SUGoHorseLampViewModel ()
{
    NSInteger _count;
    NSInteger _countOfTimer;
}
@property (nonatomic, assign) BOOL      isUsed;
@property (nonatomic, assign) BOOL      isCanceled;
@property (nonatomic, strong) dispatch_queue_t     timerQueue;
@property (nonatomic, strong) NSTimer   *timerA;
@end

@implementation SUGoHorseLampViewModel

+ (NSString *)reuseID {
    return @"goHorseCell";
}

- (instancetype)init {
    if(self = [super init]) {
        _count = 10000;
        _countOfTimer = 0;
        _currentIndex = _count / 2;
        _isCanceled   = NO;
    }
    return self;
}

- (void)startTimer {
    [[NSRunLoop currentRunLoop] addTimer:self.timerA forMode:NSDefaultRunLoopMode];
}

- (void)pauseTimer {
    [self.timerA invalidate];
    self.timerA = nil;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * const reuseID = @"goHorseCell";
    self.isUsed = YES;
    collectionView.scrollEnabled = YES;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [collectionView registerClass:[SUGoHorseLampCell class] forCellWithReuseIdentifier:reuseID];
//    });
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    SUGoHorseLampCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    NSUInteger idx = indexPath.item % self.items.count;
    SUImageManager *imageManager = [SUImageManager defaultImageManager];
    [[imageManager imageWithUrl:self.items[idx]] subscribeNext:^(id x) {
        [cell.myImageView setImage:x];
    }];
    NSLog(@"cellFor%@ %p", indexPath, cell);

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.382);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will display%@ %p", indexPath, cell);
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did end%@ %p", indexPath, cell);
    if( [cell isMemberOfClass:[SUGoHorseLampCell class]]) {
        if(self.indexHandler) {
            NSIndexPath *idx = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
            self.indexHandler(idx);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat width = scrollView.frame.size.width;
    NSInteger idx = contentOffset.x / width;
    self.currentIndex = idx;
        if(self.indexHandler) {
            NSIndexPath *idx = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
            self.indexHandler(idx);
        }
    [self startTimer];
}

#pragma mark - Getter & Setter

- (NSMutableArray *)items {
    if(!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (dispatch_source_t )timer {
    if(!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.timerQueue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        @weakify(self);
        dispatch_source_set_event_handler(_timer, ^{
            @strongify(self);
            NSIndexPath *idx = [NSIndexPath indexPathForItem:(++self.currentIndex) % _count inSection:0];
            [self.timerSignal sendNext:idx];
        });
        dispatch_source_set_cancel_handler(_timer, ^{
            NSLog(@"跑马灯定时器取消了");
        });
    }
    return _timer;
}

- (RACSubject *)timerSignal {
    if(!_timerSignal) {
        _timerSignal = [RACSubject subject];
    }
    return _timerSignal;
}

- (NSMutableArray<RACDisposable *> *)disposes {
    if(!_disposes) {
        _disposes = [NSMutableArray array];
    }
    return _disposes;
}

- (dispatch_queue_t)timerQueue {
    if(_timerQueue == NULL) {
        _timerQueue = dispatch_queue_create("com.sevenuncle.timer.gohorse", DISPATCH_QUEUE_SERIAL);
    }
    return _timerQueue;
}

- (NSTimer *)timerA {
    if(!_timerA) {
        @weakify(self);
        _timerA = [NSTimer timerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            @strongify(self);
            NSIndexPath *idx = [NSIndexPath indexPathForItem:(++self.currentIndex) % _count inSection:0];
            [self.timerSignal sendNext:idx];
        }];
    }
    return _timerA;
}

@end
