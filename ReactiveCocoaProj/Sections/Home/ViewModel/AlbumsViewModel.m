//
//  AlbumsViewModel.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "AlbumsViewModel.h"
#import "RecommandSongViewCell.h"
#import "RecommandSong.h"
#import "SUImageManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AlbumsItem.h"
#import "NetEaseMusic.h"
#import "NewSongItem.h"
#import <MJExtension/MJExtension.h>
#import "Macros.h"

@implementation AlbumsViewModel

- (void)loadData {
    [NetEaseMusic newSongWithComplectionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"推荐MV请求失败: %@", error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(!jsonError && result) {
            NSArray *MVs = result[@"result"];
            CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
            CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;

            self.items = [NewSongItem mj_objectArrayWithKeyValuesArray:MVs];
            [self.items enumerateObjectsUsingBlock:^(SUItem  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.layout.frame = CGRectMake(0, 0, itemWidth, itemHeight);
            }];
            dispatch_semaphore_signal(self.semaphore);
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count / 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    [collectionView registerClass:[RecommandSongViewCell class] forCellWithReuseIdentifier:[RecommandSongViewCell description]];
    //    });
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    RecommandSongViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RecommandSongViewCell description] forIndexPath:indexPath];
    
    NewSongItem *newSongItem = [self.items objectAtIndex:indexPath.section*2 +  indexPath.item];
    SUArtistsItem *artistItem = newSongItem.song.artists[0];
    @weakify(cell);
    [[[SUImageManager defaultImageManager] imageWithUrl:artistItem.picUrl] subscribeNext:^(id x) {
        @strongify(cell);
        cell.coverImageView.image = x;
    }];
    cell.titleLabel.text = newSongItem.name;
    cell.subTitleLabel.text = artistItem.name;
    return cell;
}
#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SUItem *item = [self.items objectAtIndex:indexPath.section*2 +  indexPath.item];
    return item.layout.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}
- (dispatch_semaphore_t)semaphore {
    if(!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

@end
