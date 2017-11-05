//
//  FriendVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "FriendVC.h"
#import "StatusView.h"
#import "Macros.h"
#import "StatusCell.h"
#import "UIView+Layout.h"
#import "SongStatusItem.h"

static NSString * const reuseSongID     = @"reuseSongID";
static NSString * const reuseVideoID    = @"reuseVideoID";
@interface FriendVC ()

@end

@implementation FriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
    [self.tableView registerClass:[SongViewCell class] forCellReuseIdentifier:reuseSongID];
    [self.tableView registerClass:[VideoViewCell class] forCellReuseIdentifier:reuseVideoID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StatusItem *statusItem = [self.items objectAtIndex:indexPath.row];
    if([statusItem isMemberOfClass:[SongStatusView class]] || true) {
        SongViewCell *songViewCell = [tableView dequeueReusableCellWithIdentifier:reuseSongID forIndexPath:indexPath];
        SongStatusItem *songStatusItem = (SongStatusItem *)statusItem;
        songViewCell.songStatusView.nameLabel.text = @"德维恩韦德";
        songViewCell.songStatusView.dateLabel.text = @"昨天 22:47";
        songViewCell.songStatusView.contentLabel.text = songStatusItem.publishText;
        songViewCell.songStatusView.images         = songStatusItem.pics.mutableCopy;
        [songViewCell.songStatusView setNeedsLayout];
        return songViewCell;
    }
//    if([statusItem isMemberOfClass:[VideoStatusView class]]) {
//        VideoViewCell *videoViewCell = [tableView dequeueReusableCellWithIdentifier:reuseVideoID forIndexPath:indexPath];
//        return videoViewCell;
//    }
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusItem *statusItem = [self.items objectAtIndex:indexPath.row];
    return statusItem.layout.frame.size.height;
}

#pragma mark - Private
- (void)loadDatas {
    {
        SongStatusItem *item = [SongStatusItem new];
        item.publishText = @"大地出征，寸草不生";
        item.pics        = @[@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2661383408,1630377023&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1229347310,2063563433&fm=200&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg"].mutableCopy;
        CGFloat itemHeight = [self viewHeightForSongItem:item];
        item.layout.frame = CGRectMake(0, 0, 0, itemHeight);
        [self.items addObject:item];
    }
    {
        SongStatusItem *item = [SongStatusItem new];
        item.publishText = @"蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花";
        item.pics        = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3512934279,3903686258&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg"].mutableCopy;
        CGFloat itemHeight = [self viewHeightForSongItem:item];
        item.layout.frame = CGRectMake(0, 0, 0, itemHeight);
        [self.items addObject:item];
    }
    {
        SongStatusItem *item = [SongStatusItem new];
        item.publishText = @"蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生";
        item.pics        = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3512934279,3903686258&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg"].mutableCopy;
        CGFloat itemHeight = [self viewHeightForSongItem:item];
        item.layout.frame = CGRectMake(0, 0, 0, itemHeight);
        [self.items addObject:item];
    }
    {
        SongStatusItem *item = [SongStatusItem new];
        item.publishText = @"韦德，迷踪步，闪电侠，腮帮，典韦，马推特大学，迈阿密，芝加哥，克利夫兰";
        item.pics        = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1509904680747&di=55c0af31f68cfdc6f813e3a01264631e&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F8718367adab44aed99c7c6edb81c8701a18bfb2a.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=295652582,767636294&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3260745850,3788058514&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=236142374,290992341&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1219030840,1469840192&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3260745850,3788058514&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=236142374,290992341&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1219030840,1469840192&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1219030840,1469840192&fm=27&gp=0.jpg"].mutableCopy;
        CGFloat itemHeight = [self viewHeightForSongItem:item];
        item.layout.frame = CGRectMake(0, 0, 0, itemHeight);
        [self.items addObject:item];
    }
    {
        SongStatusItem *item = [SongStatusItem new];
        item.publishText = @"蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生，蝴蝶穿花，钟艾一生";
        item.pics        = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3512934279,3903686258&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2235648554,347432175&fm=11&gp=0.jpg"].mutableCopy;
        CGFloat itemHeight = [self viewHeightForSongItem:item];
        item.layout.frame = CGRectMake(0, 0, 0, itemHeight);
        [self.items addObject:item];
    }
}

- (CGFloat)viewHeightForSongItem:(SongStatusItem *)item {
    static SongStatusView *songStatusView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        songStatusView = [[SongStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    });
    songStatusView.nameLabel.text = @"德维恩韦德";
    songStatusView.dateLabel.text = @"昨天 22:47";
    songStatusView.contentLabel.text = item.publishText;
    songStatusView.images         = item.pics.mutableCopy;
    [songStatusView setNeedsLayout];
    [songStatusView layoutIfNeeded];
    return songStatusView.size.height;
}



#pragma mark - Getter & Setter

- (NSMutableArray<StatusItem *> *)items {
    if(!_items) {
        _items = [NSMutableArray arrayWithCapacity:9];
    }
    return _items;
}

@end
