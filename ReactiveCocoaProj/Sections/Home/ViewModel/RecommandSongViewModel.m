//
//  RecommandSongViewModel.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "RecommandSongViewModel.h"
#import "RecommandSongViewCell.h"
#import "RecommandSong.h"
#import "SUImageManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Macros.h"
#import "NetEaseMusic.h"
#import <MJExtension/MJExtension.h>

@implementation InterModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"playLists" : @"PersonalizedItem"
             };
}


@end


@interface RecommandSongViewModel () <NSURLSessionDataDelegate>
@property (nonatomic, weak) UICollectionView *collection;
@end

@implementation RecommandSongViewModel
@synthesize items = _items;
- (instancetype)init {
    if(self = [super init]) {
        [self loadData];
    }
    return self;
}

- (void)loadData {
    [NetEaseMusic personalizedPlayListsWithComplectionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"加载数据错误：%@", error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(!jsonError && json) {
            json = json[@"result"];
            self.items = [PersonalizedItem mj_objectArrayWithKeyValuesArray:json];
            CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
            CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
            [self.items enumerateObjectsUsingBlock:^(SUItem  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.layout.frame = CGRectMake(0, 0, itemWidth, itemHeight);
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                @synchronized (self) {
                    if(self.collection)
                        [self.collection reloadData];
                }
            });
        }
    }];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
//    NSLog(@"%@", response);
    //允许服务器回传数据
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
//    NSLog(@"请求返回%@", dict);
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = dict[@"image"];
        recommandSong.title     = dict[@"title"];
        recommandSong.listenedCount = dict[@"pages"];
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [self.items addObject:recommandSong];
        
    }
}
-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    NSLog(@"请求数据错误:%@",error);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if((section == self.items.count/2) && (self.items.count%2==1)) {
        return 1;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    self.collection = collectionView;
    return self.items.count / 2 + self.items.count%2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [collectionView registerClass:[RecommandSongViewCell class] forCellWithReuseIdentifier:[RecommandSongViewCell description]];
//    });
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    RecommandSongViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RecommandSongViewCell description] forIndexPath:indexPath];
    
    PersonalizedItem *recommandSong = [self.items objectAtIndex:indexPath.section*2 +  indexPath.item];
//    NSLog(@">>>> %@", recommandSong.coverPath);
    @weakify(cell);
    @weakify(collectionView);
    [[[SUImageManager defaultImageManager] imageWithUrl:recommandSong.picUrl] subscribeNext:^(id x) {
//        NSLog(@">>>> %p %@",collectionView, x);
        @strongify(cell);
        @strongify(collectionView);
        cell.coverImageView.image = x;
//        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
    cell.titleLabel.text = recommandSong.name;
    cell.subTitleLabel.text = nil;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommandSongViewCell *cell = (RecommandSongViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
}

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
//    @synchronized(self){
    if(!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
//    }
}
- (void)setItems:(NSMutableArray *)items {
//    @synchronized(self){
        _items = [items mutableCopy];
//    }
}

@end
