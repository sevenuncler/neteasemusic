//
//  AccountVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/5.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "AccountVC.h"
#import "SUSettingItem.h"
#import "UIImage+Size.h"

@interface AccountVC ()
@end
static NSString * const reuseCell = @"reuseAccoutCell";
static NSString * const reuseCell2= @"reuseAccountCell2";
@implementation AccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCell];
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Priavte

- (void)loadData {
    {
        SUGeneralItem *generalItem = [SUGeneralItem new];
        //header
        //items
        {
            {
            SUSettingItem *settingItem = [SUSettingItem new];
            settingItem.leftImage = @"drew";
            settingItem.title     = @"七大爷";
            settingItem.subTitle = @"等级 999";
            settingItem.style     = UITableViewCellStyleSubtitle;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 88);
            [generalItem.contentItems addObject:settingItem];
            }
        }
        [self.items addObject:generalItem];
    }
    {
        SUGeneralItem *generalItem = [SUGeneralItem new];
        //header
        SUItem *header      = [SUItem new];
        header.layout.frame = CGRectMake(0, 0, 0, 10);
        generalItem.header  = header;
        //items
        {
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_mail";
                settingItem.title     = @"我的消息";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
        }
        [self.items addObject:generalItem];
    }
    {
        SUGeneralItem *generalItem = [SUGeneralItem new];
        //header
        SUItem *header      = [SUItem new];
        header.layout.frame = CGRectMake(0, 0, 0, 10);
        generalItem.header  = header;
        //items
        {
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_vip";
                settingItem.title     = @"会员中心";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_store";
                settingItem.title     = @"商城";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_combo";
                settingItem.title     = @"在线听歌免流量";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
        }
        [self.items addObject:generalItem];
    }
    {
        SUGeneralItem *generalItem = [SUGeneralItem new];
        //header
        SUItem *header      = [SUItem new];
        header.layout.frame = CGRectMake(0, 0, 0, 10);
        generalItem.header  = header;
        //items
        {
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_set";
                settingItem.title     = @"设置";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_scan";
                settingItem.title     = @"扫一扫";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_skin";
                settingItem.title     = @"个性换肤";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_night";
                settingItem.title     = @"夜间模式";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_time";
                settingItem.title     = @"定时关闭";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_alamclock";
                settingItem.title     = @"音乐闹钟";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_vehicle";
                settingItem.title     = @"驾驶模式";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
        }
        [self.items addObject:generalItem];
    }
    {
        SUGeneralItem *generalItem = [SUGeneralItem new];
        //header
        SUItem *header      = [SUItem new];
        header.layout.frame = CGRectMake(0, 0, 0, 10);
        generalItem.header  = header;
        //items
        {
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_share";
                settingItem.title     = @"分享网易云音乐";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.leftImage = @"cm2_set_icn_about";
                settingItem.title     = @"关于";
                settingItem.style     = 1;
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
        }
        [self.items addObject:generalItem];
    }
    {
        SUGeneralItem *generalItem = [SUGeneralItem new];
        //header
        SUItem *header      = [SUItem new];
        header.layout.frame = CGRectMake(0, 0, 0, 10);
        generalItem.header  = header;
        //items
        {
            {
                SUSettingItem *settingItem = [SUSettingItem new];
                settingItem.title     = @"退出登录";
                settingItem.layout.frame = CGRectMake(0, 0, 0, 40);
                [generalItem.contentItems addObject:settingItem];
            }
        }
        [self.items addObject:generalItem];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SUGeneralItem *generalItem = [self.items objectAtIndex:section];
    return generalItem.contentItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SUGeneralItem *generalItem = [self.items objectAtIndex:indexPath.section];
    SUSettingItem *settingItem = (SUSettingItem *)[generalItem.contentItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = nil;
    UIImage *image;
    if(settingItem.style == UITableViewCellStyleSubtitle) {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseCell2];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseCell2];
        }
        cell.detailTextLabel.text = settingItem.subTitle;
        image = [UIImage imageNamed:settingItem.leftImage].round(CGSizeMake(60, 60), 30);
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
        image = [UIImage imageNamed:settingItem.leftImage];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = image;
    cell.textLabel.text  = settingItem.title;
    if(indexPath.section == self.items.count-1) {
        cell.textLabel.textAlignment =  NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else {
        cell.textLabel.textAlignment =  NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SUGeneralItem *generalItem = [self.items objectAtIndex:indexPath.section];
    SUSettingItem *settingItem = (SUSettingItem *)[generalItem.contentItems objectAtIndex:indexPath.row];
    return settingItem.layout.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SUGeneralItem *generalItem = [self.items objectAtIndex:section];
    return generalItem.header.layout.frame.size.height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
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

- (NSMutableArray<SUGeneralItem *> *)items {
    if(!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
