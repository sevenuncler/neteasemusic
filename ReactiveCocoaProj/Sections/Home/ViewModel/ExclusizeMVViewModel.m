//
//  ExclusizeMVViewModel.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "ExclusizeMVViewModel.h"
#import "MVViewCell.h"
#import "NetEaseMusic.h"
#import "ExclusiveMVItem.h"
#import <MJExtension/MJExtension.h>
#import "Macros.h"
#import "UIView+Layout.h"
#import "SUImageManager.h"

static NSString * const reuseID = @"reuseMVViewCell";
@implementation ExclusizeMVViewModel
{
    __weak UICollectionView *_collectionView;
}
- (instancetype)init {
    if(self = [super init]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpSize];
        });
//        if(self.items == nil) {
//            [self loadData];
//        }
    }
    return self;
}

- (CGSize)setUpSize {
    static MVViewCell *mvCell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            mvCell = [[MVViewCell alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 10)/2, 0)];
            [mvCell setNeedsLayout];
            [mvCell layoutIfNeeded];
    });
    CGSize size;
    do{
        size = CGSizeMake(mvCell.size.width, mvCell.nameL.botton);
    }while (!mvCell);
    return size;
}

- (void)loadData {
    [NetEaseMusic excludeMVWithComplectionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"推荐MV请求失败: %@", error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(!jsonError && result) {
            NSArray *MVs = result[@"data"];
            self.items = [ExclusiveMVItem mj_objectArrayWithKeyValuesArray:MVs];
            CGSize size = [self setUpSize];
            [self.items enumerateObjectsUsingBlock:^(SUItem  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.layout.frame = CGRectMake(0, 0, size.width, size.height);
            }];
            dispatch_semaphore_signal(self.semaphore);
            if(_collectionView) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_collectionView reloadData];
                });
            }
        }

    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _collectionView = collectionView;
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.items.count>=2)
        return 2;
    else {
        return self.items.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView registerClass:[MVViewCell class] forCellWithReuseIdentifier:reuseID];
    MVViewCell *cell = (MVViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    ExclusiveMVItem *item = [self.items objectAtIndex:indexPath.section];
    SUImageManager *imageManager = [SUImageManager defaultImageManager];
    [[imageManager imageWithUrl:item.cover] subscribeNext:^(UIImage *x) {
        cell.coverIV.image = x;
    }];
    cell.nameL.text = item.name;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SUItem *item = [self.items objectAtIndex:indexPath.section];
    return item.layout.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 100;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 190;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 5);
}

- (dispatch_semaphore_t)semaphore {
    if(!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

@end
