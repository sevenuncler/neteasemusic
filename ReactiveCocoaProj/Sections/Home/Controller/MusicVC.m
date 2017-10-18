//
//  MusicVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "MusicVC.h"
#import "SUCollectionViewCell.h"
#import "SUGoHorseLampView.h"
#import "SUGoHorseLampViewModel.h"
#import "Macros.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MusicVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray             *items;
@property (nonatomic, strong) SUGoHorseLampViewModel     *goHorseLampVM;

@end

static NSString * const reuseID = @"reuseID";
@implementation MusicVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    [self setUpGoHorseView];

    [self.view addSubview:self.collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SUCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    UIView *view = [self.items objectAtIndex:indexPath.section];
    cell.myContentView = view;
    return cell;
}

- (void)setUpGoHorseView {
    SUGoHorseLampView *view = [[SUGoHorseLampView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.618)];
    
    self.goHorseLampVM = [SUGoHorseLampViewModel new];
    self.goHorseLampVM.items = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg", @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3257648166,2653121674&fm=27&gp=0.jpg", @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg", @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3396335410,3051374929&fm=27&gp=0.jpg"].mutableCopy;
    @weakify(self);
    [self.goHorseLampVM.timerSignal subscribeNext:^(id x) {
        @strongify(self);
        [view scrollToItemAtIndexPath:x atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }];
    
    view.dataSource = self.goHorseLampVM;
    view.delegate   = self.goHorseLampVM;
    
    [self.items addObject:view];
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.618);
}

#pragma mark - Getter & Setter

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.dataSource     = self;
        _collectionView.delegate       = self;
        [_collectionView registerClass:[SUCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(nil == _flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
