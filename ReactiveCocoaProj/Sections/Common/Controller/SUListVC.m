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

@interface SUListVC ()

@end
static NSString * const reuseIdentifier = @"reuseSongListCell";
@implementation SUListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SUSongListCell class] forCellReuseIdentifier:reuseIdentifier];
    [self songListItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songListItem.tracks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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

- (SongList *)songListItem {
    if(!_songListItem) {
        _songListItem = [SongList new];
        dispatch_semaphore_t semphore = dispatch_semaphore_create(0);
        __block NSDictionary *dataDict;
        
        [NetEaseMusicApi playlistInfoWithPlaylistId:387699584 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error) {
                NSLog(@"请求出错 %@", error);
                dispatch_semaphore_signal(semphore);
                return;
            }
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"返回结果1:%@", string);
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"返回结果2: \n%@", dict);
            NSDictionary *result = dict[@"result"];
            [_songListItem setValuesForKeysWithDictionary:result];
            dispatch_semaphore_signal(semphore);
        }];
        if(dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER) == 0) {
            [self.tableView reloadData];
        }
        
        
    }
    return _songListItem;
}

@end
