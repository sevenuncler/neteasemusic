//
//  SUListVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/15.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUListVC.h"
#import "SUSongListCell.h"
#import "NetEaseMusicApi.h"
#import "SongList.h"
#import "SUTrackItem.h"
#import <MJExtension/MJExtension.h>
#import "SUSongListTopView.h"
#import "UIView+Layout.h"
#import "NetEaseMusic.h"
#import "SUBannerItem.h"
#import "SUTableViewCell.h"
#import "SUImageManager.h"
#import "SUUserItem.h"
#import "SUPlayerViewController.h"

@interface SUListVC ()

@end
static NSString * const reuseIdentifierTopView  = @"reuseSongListCellTopView";
static NSString * const reuseIdentifier         = @"reuseSongListCell";
@implementation SUListVC
@synthesize songListItem = _songListItem;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[SUSongListCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerClass:[SUTableViewCell class] forCellReuseIdentifier:reuseIdentifierTopView];
    [self songListItem];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.songListItem) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.songListItem && 1 == section) {
        return self.songListItem.tracks.count;
    }else if(0 == section) {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(0 == indexPath.section) {
        SUTableViewCell *tabelViewCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTopView forIndexPath:indexPath];
        
        SUSongListTopView *topView = [[SUSongListTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width, 250)];
        SUImageManager *imageManager = [SUImageManager defaultImageManager];
        //封面
        [[imageManager imageWithUrl:self.songListItem.coverImgUrl] subscribeNext:^(UIImage *x) {
            topView.coverIV.image = x;
        }];
        //用户头像
        [[imageManager imageWithUrl:self.songListItem.creator.avatarUrl] subscribeNext:^(UIImage *x) {
            topView.avatorIV.image = x;
        }];
        topView.nameLabel.text = self.songListItem.name;
        topView.likedNumLabel.text   = [NSString stringWithFormat:@"%ld", self.songListItem.subscribedCount];
        topView.commentNumLabel.text = [NSString stringWithFormat:@"%ld", self.songListItem.commentCount];
        topView.trandNumLabel.text   = [NSString stringWithFormat:@"%ld", self.songListItem.shareCount];
        
        tabelViewCell.myContentView = topView;
        return tabelViewCell;
    }
    SUSongListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    SUTrackItem *trackItem = self.songListItem.tracks[indexPath.row];
    cell.indexLabel.text   = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.textLabel.text    = trackItem.name;
    cell.detailTextLabel.text = trackItem.artists[0].name;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(0 == indexPath.section) {
        return 250;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        SUPlayerViewController *vc = [SUPlayerViewController sharedInstance];
        vc.playList = self.songListItem;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (SongList *)songListItem {
    if(!_songListItem) {
        _songListItem = [SongList new];
        if(self.songListID) {
            [NetEaseMusic playListDetailWithID:self.songListID complection:^(NSData *data, NSURLResponse *response, NSError *error) {
                if(error) {
                    NSLog(@"请求出错 %@", error);
                    return;
                }
                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"返回结果1:%@", string);
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"返回结果2: \n%@", dict);
                NSDictionary *result = dict[@"playlist"];
                _songListItem = [SongList mj_objectWithKeyValues:result];
                if(_songListItem == nil) {
                    _songListItem = [SongList new];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
//            [NetEaseMusicApi playlistInfoWithPlaylistId:self.songListID.integerValue  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                if(error) {
//                    NSLog(@"请求出错 %@", error);
//                    return;
//                }
//                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"返回结果1:%@", string);
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"返回结果2: \n%@", dict);
//                NSDictionary *result = dict[@"result"];
//                _songListItem = [SongList mj_objectWithKeyValues:result];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
//                });
//            }];
        }
        
    }
    return _songListItem;
}

- (void)setSongListItem:(SongList *)songListItem {
    if(_songListItem != songListItem) {
        _songListItem = songListItem;
        [self.tableView reloadData];
    }
}

- (NSString *)songListID {
    if(nil == _songListID) {
        _songListID = @"387699584";
    }
    return _songListID;
}

@end
