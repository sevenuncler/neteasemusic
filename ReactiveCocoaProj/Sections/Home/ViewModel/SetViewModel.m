//
//  SetViewModel.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SetViewModel.h"
#import "SongSetView.h"
#import "SUItem.h"
#import "SUImageManager.h"
#import "SongSetItem.h"
#import "UIImage+Size.h"

@implementation SetViewModel


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.scrollEnabled = NO;
    //    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [collectionView registerClass:[SongSetView class] forCellWithReuseIdentifier:[SongSetView reuseID]];
//    });
    collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    SongSetView *songSetViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:[SongSetView reuseID] forIndexPath:indexPath];
    SongSetItem *item = [self.items objectAtIndex:indexPath.item];
 
    songSetViewCell.imageView.image = [UIImage imageNamed:item.coverImage].roundWithBoard(CGSizeMake(30, 30),15,0.8);

    songSetViewCell.label.text = item.title;
    [songSetViewCell setNeedsLayout];
    return songSetViewCell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SUItem *item = [self.items objectAtIndex:indexPath.item];
    return item.layout.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 23;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger idx = indexPath.item % self.items.count;
}

@end
