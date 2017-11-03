//
//  MyMusicVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/2.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "MyMusicVC.h"
#import "SUGeneralItem.h"
#import "MyMusicViewStaticCell.h"
#import "MyMusicItem.h"

@interface MyMusicVC ()

@end


@implementation MyMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadItems];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)loadItems {
    NSMutableArray *items = [NSMutableArray new];
    {

        SUGeneralItem *item = [SUGeneralItem new];
        item.contentItems   = [NSMutableArray array];
        {
            MyMusicItem *musicItem = [MyMusicItem new];
            musicItem.titleString  = @"本地音乐";
            musicItem.countString  = @"0";
            musicItem.fileURLString = @"cm4_my_icn_music";
            [item.contentItems addObject:musicItem];
        }
        {
            MyMusicItem *musicItem = [MyMusicItem new];
            musicItem.titleString  = @"最近播放";
            musicItem.countString  = @"100";
            musicItem.fileURLString = @"cm4_my_icn_recent";
            [item.contentItems addObject:musicItem];
        }
        {
            MyMusicItem *musicItem = [MyMusicItem new];
            musicItem.titleString  = @"我的电台";
            musicItem.countString  = @"2";
            musicItem.fileURLString = @"cm4_my_icn_radio";
            [item.contentItems addObject:musicItem];
        }
        {
            MyMusicItem *musicItem = [MyMusicItem new];
            musicItem.titleString  = @"我的收藏";
            musicItem.countString  = @"11";
            musicItem.fileURLString = @"cm4_my_icn_fav";
            [item.contentItems addObject:musicItem];
        }
        [items addObject:item];
    }
//    {
//        SUGeneralItem *item = [SUGeneralItem new];
//        [items addObject:item];
//    }
//    {
//        SUGeneralItem *item = [SUGeneralItem new];
//        [items addObject:item];
//    }
    self.items = items.mutableCopy;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SUGeneralItem *generalItem = [self.items objectAtIndex:section];
    return generalItem.contentItems.count;
}

static NSString *reuseID1 = @"reuseIdentifier1";
static NSString *reuseID2 = @"reuseIdentifier2";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMusicViewStaticCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID1];
    if(!cell) {
        cell = [[MyMusicViewStaticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID1];
    }
    SUGeneralItem *generalItem = [self.items objectAtIndex:indexPath.section];
    MyMusicItem *item = (MyMusicItem *)[generalItem.contentItems objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:item.fileURLString];
    cell.textLabel.text  = item.titleString;
    cell.detailTextLabel.text = item.subTitleString;
    cell.countLabel.text = item.countString;
    return cell;
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

@end
