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
#import "ReuseCollectionViewCell.h"
#import "GeneralModel.h"
#import "SUGoHorseLampCell.h"
#import "SetViewModel.h"
#import "SongSetView.h"
#import "SUItem.h"
#import "SongSetItem.h"
#import "RecommandSongViewModel.h"
#import "RecommandSong.h"
#import "AlbumsItem.h"
#import "AlbumsViewModel.h"
#import "UIView+Layout.h"


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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.collectionView];

    [self setUpGoHorseView];
    [self setUpSetView];
    [self setUpRecommandSongView];
    [self setUpAnchorView];
    [self setUpNewestView];
    [self setUpMVView];
    [self setUpExclusizeView];
    
    
    
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

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GeneralModel *generalModel = [self.items objectAtIndex:indexPath.section];
    ReuseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:generalModel.reuseID forIndexPath:indexPath];
    cell.collectionView.dataSource = generalModel.viewModel;
    cell.collectionView.delegate   = generalModel.viewModel;
    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    GeneralModel *generalModel = [self.items objectAtIndex:indexPath.section];
    return generalModel.layout.frame.size;
}

#pragma mark - Internal
/*
 * 1. 定制视图
 * 2. 建立模型
 * 3. 建立ViewModel
 * 4. 配置数据
 */

- (void)setUpExclusizeView {
    CGFloat itemWidth  = SCREEN_WIDTH / 2 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 2 + 25;
    GeneralModel *generalModel = [GeneralModel new];
    
    AlbumsViewModel *viewModel = [AlbumsViewModel new];
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title     = @"七里香";
        item.subTitle  = @"周杰伦";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    generalModel.viewModel = viewModel;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight + 20);
    generalModel.layout = layout;
    
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpMVView {
    CGFloat itemWidth  = SCREEN_WIDTH / 2 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 2 + 25;
    GeneralModel *generalModel = [GeneralModel new];
    
    AlbumsViewModel *viewModel = [AlbumsViewModel new];
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title     = @"七里香";
        item.subTitle  = @"周杰伦";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    generalModel.viewModel = viewModel;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight * 2 + 20);
    generalModel.layout = layout;
    
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpNewestView {
    CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
    GeneralModel *generalModel = [GeneralModel new];
    
    AlbumsViewModel *viewModel = [AlbumsViewModel new];
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title     = @"鸟的相世";
        item.subTitle  = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    {
        AlbumsItem *item = [AlbumsItem new];
        item.title = @"鸟的相世";
        item.subTitle = @"唐映枫";
        item.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        item.layout    = layout;
        [viewModel.items addObject:item];
    }
    generalModel.viewModel = viewModel;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight * 2 + 20);
    generalModel.layout = layout;
    
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}
- (void)setUpAnchorView {
    CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 10;
    GeneralModel *generalModel = [GeneralModel new];
    
    RecommandSongViewModel *recommandSongVM = [RecommandSongViewModel new];
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }{
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }{
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    
    generalModel.viewModel = recommandSongVM;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight * 2 + 20);
    generalModel.layout = layout;
    
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpRecommandSongView {
    CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
    GeneralModel *generalModel = [GeneralModel new];

    RecommandSongViewModel *recommandSongVM = [RecommandSongViewModel new];
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }{
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }{
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        recommandSong.title     = @"如何把一份外卖吃出仪式感";
        recommandSong.listenedCount = @"999万";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    
    generalModel.viewModel = recommandSongVM;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight * 2 + 20);
    generalModel.layout = layout;
    
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpGoHorseView {
    SUGoHorseLampView *view = [[SUGoHorseLampView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.382)];
    SUGoHorseLampViewModel *viewModel;
    self.goHorseLampVM = [SUGoHorseLampViewModel new];
    self.goHorseLampVM.items = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg", @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3257648166,2653121674&fm=27&gp=0.jpg", @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg", @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3396335410,3051374929&fm=27&gp=0.jpg"].mutableCopy;
//    @weakify(view);
//    [self.goHorseLampVM.timerSignal subscribeNext:^(id x) {
//        @strongify(view);
//        [view scrollToItemAtIndexPath:x atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    }];
    view.dataSource = self.goHorseLampVM;
    view.delegate   = self.goHorseLampVM;
    viewModel = self.goHorseLampVM;
    
    GeneralModel *oneGeneralModel = [GeneralModel new];
    oneGeneralModel.viewModel = viewModel;
    Layout *layout = [Layout new];
    layout.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.382);;
    oneGeneralModel.layout = layout;
    oneGeneralModel.reuseID = [ReuseCollectionViewCell reuseID];
    [self.items addObject:oneGeneralModel];
}

- (void)setUpSetView {
    float width   = 70.f;
    float height  = 85.f;
    SetViewModel *viewModel = [SetViewModel new];
    NSMutableArray *items = @[].mutableCopy;
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        songSetItem.title = @"私人FM";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        songSetItem.title = @"私人FM";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        songSetItem.title = @"私人FM";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg";
        songSetItem.title = @"私人FM";
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    viewModel.items = items.mutableCopy;
    
    GeneralModel *generalModel = [GeneralModel new];
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    generalModel.viewModel = viewModel;
    Layout *layout = [Layout new];
    layout.frame = CGRectMake(0, 0, SCREEN_WIDTH, height + 30);
    generalModel.layout = layout;
    [self.items addObject:generalModel];
}


#pragma mark - Getter & Setter

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource     = self;
        _collectionView.delegate       = self;
        [_collectionView registerClass:[SUCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
        [_collectionView registerClass:[ReuseCollectionViewCell class] forCellWithReuseIdentifier:[ReuseCollectionViewCell reuseID]];
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
