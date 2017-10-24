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

@implementation AlbumsViewModel

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
    
    AlbumsItem *albumsItem = [self.items objectAtIndex:indexPath.section*2 +  indexPath.item];
    @weakify(cell);
    [[[SUImageManager defaultImageManager] imageWithUrl:albumsItem.coverPath] subscribeNext:^(id x) {
        @strongify(cell);
        cell.coverImageView.image = x;
    }];
    cell.titleLabel.text = albumsItem.title;
    cell.subTitleLabel.text = albumsItem.subTitle;
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

@end