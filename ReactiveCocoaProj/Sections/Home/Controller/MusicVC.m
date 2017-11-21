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
#import "HeaderView.h"
#import "FooterView.h"
#import "GoHorseCollectionViewCell.h"
#import "NetEaseMusicApi.h"
#import "SongList.h"
#import "NetEaseMusic.h"
#import <MJExtension/MJExtension.h>
#import "SUBannerItem.h"
#import "ExclusizeMVViewModel.h"


@interface MusicVC ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray             *items;
@property (nonatomic, strong) SUGoHorseLampViewModel     *goHorseLampVM;
@property (nonatomic, strong) UILabel *backgroundText;

@end

static NSString * const reuseID = @"reuseID";
static NSString * const reuseID2 = @"reuseID2";
static BOOL stopFlag = YES;
@implementation MusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.view insertSubview:self.backgroundText belowSubview:self.collectionView];

    [self setUpGoHorseView];
    [self setUpSetView];
    [self setUpRecommandSongView];
    [self setUpExclusiveMVView];
    [self setUpNewestView];
    [self setUpAnchorView];

//    [self setUpMVView];
//    [self setUpExclusizeView];
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
    NSString *reuseHeader = @"reuseHeader";
    NSString *reuseFotter = @"reuseFooter";
    UICollectionReusableView *reuseView;
    GeneralModel *generalModel = [self.items objectAtIndex:indexPath.section];
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        HeaderView *headerView = (HeaderView *)reuseView;
        headerView.titleLable.text = generalModel.headerTitle;
    }else {
        reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseFotter forIndexPath:indexPath];
    }
    return reuseView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GeneralModel *generalModel = [self.items objectAtIndex:indexPath.section];
    ReuseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:generalModel.reuseID forIndexPath:indexPath];
    cell.collectionView.dataSource = generalModel.viewModel;
    cell.collectionView.delegate   = generalModel.viewModel;
    
    //TODO 待优化，耦合度太高
    if([generalModel.viewModel isKindOfClass:[SUGoHorseLampViewModel class]]) {
        [cell.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:5000 inSection:0]atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        SUGoHorseLampViewModel *vm = (SUGoHorseLampViewModel *)generalModel.viewModel;
        
        GoHorseCollectionViewCell *goHorseCell = (GoHorseCollectionViewCell *)cell;
        goHorseCell.pageControl.numberOfPages = vm.items.count;
        goHorseCell.pageControl.currentPage   = 5000 % vm.items.count;
        [vm.disposes enumerateObjectsUsingBlock:^(RACDisposable * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [vm.disposes removeObject:obj];
            [obj dispose];
        }];
        
        __weak typeof(GoHorseCollectionViewCell) *weakGoHorseCell = goHorseCell;
        RACDisposable *disposable = [vm.timerSignal subscribeNext:^(NSIndexPath *x) {
            dispatch_async(dispatch_get_main_queue(), ^{
              [cell.collectionView scrollToItemAtIndexPath:x atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            });
        }];
        vm.indexHandler = ^(NSIndexPath *idx) {
            __strong typeof(GoHorseCollectionViewCell) *strongGoHorseCell = weakGoHorseCell;
            strongGoHorseCell.pageControl.currentPage = idx.item % strongGoHorseCell.pageControl.numberOfPages;
            
        };
        [vm.disposes addObject:disposable];
        [vm startTimer];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    GeneralModel *generalModel = [self.items objectAtIndex:indexPath.section];
    return generalModel.layout.frame.size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    GeneralModel *generalModel = [self.items objectAtIndex:section];
    return generalModel.headerSize;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    GeneralModel *generalModel = [self.items objectAtIndex:section];
    return generalModel.footerSize;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        GeneralModel *gModel = [self.items objectAtIndex:0];
        SUGoHorseLampViewModel *vm = (SUGoHorseLampViewModel *)(gModel.viewModel);
        if([vm isMemberOfClass:[SUGoHorseLampViewModel class]]) {
            [vm startTimer];
        }
        stopFlag = YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!stopFlag) {
        return;
    }
    CGPoint contentOffset = scrollView.contentOffset;
    GeneralModel *generalModel = [self.items objectAtIndex:0];

    if(contentOffset.y>generalModel.layout.frame.size.height) {
        SUGoHorseLampViewModel *vm = (SUGoHorseLampViewModel *)generalModel.viewModel;
        [vm pauseTimer];
        stopFlag = NO;
    }
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
    generalModel.headerSize = CGSizeMake(self.view.size.width, 44);
    generalModel.headerTitle = @"推荐MV";
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
    generalModel.headerSize = CGSizeMake(self.view.size.width, 44);
    generalModel.headerTitle = @"最新音乐";
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpNewestView {
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
    GeneralModel *generalModel = [GeneralModel new];
    
    AlbumsViewModel *viewModel = [AlbumsViewModel new];

    generalModel.viewModel = viewModel;
    [viewModel loadData];
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight * 2 + 20);
    generalModel.layout = layout;
    generalModel.headerSize = CGSizeMake(self.view.size.width, 44);
    generalModel.headerTitle = @"最新音乐";
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(dispatch_semaphore_wait(viewModel.semaphore, DISPATCH_TIME_FOREVER) == 0) {
            [self.items insertObject:generalModel atIndex:4];
            [self.collectionView reloadData];
        }
    });
}
- (void)setUpAnchorView {
    __block NSDictionary *result = nil;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [NetEaseMusicApi playlistInfoWithPlaylistId:387699584 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"请求歌单出错 %@", error);
            return;
        }
        NSError *errorJson = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
        if(!errorJson && json) {
            result = json[@"result"];
        }
        dispatch_semaphore_signal(semaphore);
    }];
    if(dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) != 0) {
        return;
    }
    CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
    GeneralModel *generalModel = [GeneralModel new];
    
    SongList *songList = [SongList new];
    [songList setValuesForKeysWithDictionary:result];
    
    RecommandSongViewModel *recommandSongVM = [RecommandSongViewModel new];
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = result[@"coverImgUrl"];
        recommandSong.title     = result[@"name"];
        recommandSong.listenedCount = [NSString stringWithFormat:@"%@", result[@"playCount"]];
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, itemWidth, itemHeight);
        recommandSong.layout = layout;
        [recommandSongVM.items addObject:recommandSong];
    }
    {
        RecommandSong *recommandSong = [RecommandSong new];
        recommandSong.coverPath = result[@"coverImgUrl"];
        recommandSong.title     = result[@"name"];
        recommandSong.listenedCount = [NSString stringWithFormat:@"%@", result[@"playCount"]];
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
    generalModel.headerSize = CGSizeMake(self.view.size.width, 44);
    generalModel.headerTitle = @"主播电台";
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpExclusiveMVView {
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
    GeneralModel *generalModel = [GeneralModel new];
    
    ExclusizeMVViewModel *recommandSongVM = [ExclusizeMVViewModel new];
    [recommandSongVM loadData];
    
    generalModel.viewModel = recommandSongVM;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.5 * 0.618);
    generalModel.layout = layout;
    generalModel.headerSize = CGSizeMake(self.view.size.width, 44);
    generalModel.headerTitle = @"独家MV";
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(dispatch_semaphore_wait(recommandSongVM.semaphore, DISPATCH_TIME_FOREVER) == 0) {
            [self.items insertObject:generalModel atIndex:3];
            [self.collectionView reloadData];
        }
    });
}

- (void)setUpRecommandSongView {
//    CGFloat itemWidth  = SCREEN_WIDTH / 3 - 10;
    CGFloat itemHeight = SCREEN_WIDTH / 3 + 25;
    GeneralModel *generalModel = [GeneralModel new];

    RecommandSongViewModel *recommandSongVM = [RecommandSongViewModel new];
    generalModel.viewModel = recommandSongVM;
    
    Layout *layout = [Layout new];
    layout.frame   = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight * 2 + 20);
    generalModel.layout = layout;
    generalModel.headerSize = CGSizeMake(self.view.size.width, 44);
    generalModel.headerTitle = @"推荐歌单";
    generalModel.reuseID = [ReuseCollectionViewCell reuseID];
    
    [self.items addObject:generalModel];
}

- (void)setUpGoHorseView {
//    SUGoHorseLampView *view = [[SUGoHorseLampView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.382)];
    SUGoHorseLampViewModel *viewModel;
    self.goHorseLampVM = [SUGoHorseLampViewModel new];
    viewModel = self.goHorseLampVM;
    
    GeneralModel *oneGeneralModel = [GeneralModel new];
    oneGeneralModel.viewModel = viewModel;
    Layout *layout = [Layout new];
    layout.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.382);;
    oneGeneralModel.layout = layout;
    oneGeneralModel.reuseID = [GoHorseCollectionViewCell reuseID];
    
    [NetEaseMusic bannerWithComplection:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"加载Banner失败： %@", error);
            return;
        }
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arrays = responseDict[@"banners"];
        NSMutableArray *banners = @[].mutableCopy;
        [arrays enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SUBannerItem *bannerItem = [SUBannerItem new];
            [bannerItem setValuesForKeysWithDictionary:obj];
            [banners addObject:bannerItem];
        }];
        self.goHorseLampVM.items = banners.mutableCopy;
        [self.items insertObject:oneGeneralModel atIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];

}

- (void)setUpSetView {
    float width   = 70.f;
    float height  = 85.f;
    SetViewModel *viewModel = [SetViewModel new];
    NSMutableArray *items = @[].mutableCopy;
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"cm4_disc_topbtn_fm";
        songSetItem.title = @"私人FM";
        songSetItem.songSetType = SongSetTypePrivateFM;
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"cm4_disc_topbtn_daily";
        songSetItem.title = @"每日推荐";
        songSetItem.songSetType = SongSetTypeDailyRecommend;
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"cm4_disc_topbtn_list";
        songSetItem.title = @"歌单";
        songSetItem.songSetType = SongSetTypePlayList;
        Layout *layout = [Layout new];
        layout.frame   = CGRectMake(0, 0, width, height);
        songSetItem.layout = layout;
        [items addObject:songSetItem];
    }
    {
        SongSetItem *songSetItem = [SongSetItem new];
        songSetItem.coverImage = @"cm4_disc_topbtn_rank";
        songSetItem.title = @"排行榜";
        songSetItem.songSetType = SongSetTypeRank;
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
    generalModel.footerSize = CGSizeMake(self.view.size.width, 0.5);
    [self.items addObject:generalModel];
}


#pragma mark - Getter & Setter

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.size = CGSizeMake(self.view.size.width, self.view.size.height-200);
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource     = self;
        _collectionView.delegate       = self;
        [_collectionView registerClass:[SUCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
        [_collectionView registerClass:[ReuseCollectionViewCell class] forCellWithReuseIdentifier:[ReuseCollectionViewCell reuseID]];
        [_collectionView registerClass:[GoHorseCollectionViewCell class] forCellWithReuseIdentifier:[GoHorseCollectionViewCell reuseID]];

        [_collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuseHeader"];
        [_collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"reuseFooter"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(nil == _flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (UILabel *)backgroundText {
    if(!_backgroundText) {
        _backgroundText = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 30)];
        _backgroundText.text = @"首页根据你口味生成";
        _backgroundText.centerX = SCREEN_WIDTH/2;
        _backgroundText.textAlignment = NSTextAlignmentCenter;
        _backgroundText.font = [UIFont systemFontOfSize:12];
    }
    return _backgroundText;
}

@end
