//
//  SUHomeVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUHomeVC.h"
#import "SUItem.h"
#import "SUGoHorseLampView.h"
#import "SUGoHorseLampViewModel.h"
#import "SUTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ViewController.h"
#import "TransitionManager.h"
#import "Animator.h"
#import "Macros.h"
#import "SUCollectionViewCell.h"
#import "MusicVC.h"
#import "VideoVC.h"
#import "RadioVC.h"
#import "CatagoryView.h"
#import "UIView+Layout.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SUHomeVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collecctionView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) SUGoHorseLampView *goHorseLampView;
@property (nonatomic, strong) SUGoHorseLampViewModel *goHorseLampVM;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) CatagoryView *firstView;

@end

static NSString * const reuseID = @"reuseID";
@implementation SUHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.items addObject:[MusicVC new]];
    [self.items addObject:[RadioVC new]];
    [self.items addObject:[VideoVC new]];
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.collecctionView];
    
    @weakify(self);
    [[self.firstView selectedIndexSignal] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        [self.collecctionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[x integerValue] inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.firstView.segmentedControl.selectedSegmentIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SUCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    UIViewController *vc = (UIViewController *)[self.items objectAtIndex:indexPath.item];
    cell.myContentView = vc.view;
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collecctionView.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset =  scrollView.contentOffset;
    NSInteger x = (NSInteger)contentOffset.x;
    CGFloat   progress =  x / SCREEN_WIDTH;
    self.firstView.underLineProgress(progress);
}

#pragma mark - Getter && Setter

- (CatagoryView *)firstView {
    if(!_firstView) {
        _firstView = [[CatagoryView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44) items:@[@"音乐",@"视频",@"电台"]];
    }
    return _firstView;
}

- (UICollectionView *)collecctionView {
    if(!_collecctionView) {
        _collecctionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.firstView.botton, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.firstView.size.height - 44) collectionViewLayout:self.flowLayout];
        _collecctionView.dataSource     = self;
        _collecctionView.delegate       = self;
        _collecctionView.pagingEnabled  = YES;
        _collecctionView.backgroundColor = [UIColor orangeColor];
        [_collecctionView registerClass:[SUCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    }
    return _collecctionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(nil == _flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
