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
}
@property (nonatomic, assign) BOOL      isUsed;

@end

@implementation SUGoHorseLampViewModel

+ (NSString *)reuseID {
    return @"goHorseCell";
}

- (instancetype)init {
    if(self = [super init]) {
        _count = 10000;
    }
    return self;
}

- (void)startTimer {
    @synchronized (self) {
            dispatch_resume(self.timer);
    }
}

- (void)pauseTimer {
    @synchronized (self) {
        dispatch_suspend(self.timer);
    }
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
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.382);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if( [cell isMemberOfClass:[SUGoHorseLampCell class]]) {
        if(self.indexHandler) {
            self.indexHandler(indexPath);
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startTimer];
    });
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self startTimer];

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
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        @weakify(self);
        dispatch_source_set_event_handler(_timer, ^{
            @strongify(self);
            NSIndexPath *idx = [NSIndexPath indexPathForItem:(++ self.currentIndex) % _count inSection:0];
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

@end
