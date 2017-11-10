//
//  AdVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/16.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "AdVC.h"
#import "SUHomeVC.h"
#import "Macros.h"
#import "UIImage+Size.h"
#import "SUPlayerViewController.h"
#import "MyTabBarController.h"
#import "MyMusicVC.h"
#import "FriendVC.h"
#import "AccountVC.h"

@interface AdVC ()

@end

@implementation AdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:@"jhht.jpg"];
    [self.view addSubview:imageView];
    [self performSelector:@selector(transiteMainVC:) withObject:nil afterDelay:0];
}

- (void)transiteMainVC:(id)sender {
    NSMutableArray *controllers = @[].mutableCopy;
    {
        UIViewController *vc = [[SUHomeVC alloc] init];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        tabBarItem.image = [UIImage imageNamed:@"cm2_btm_icn_discovery"];
        tabBarItem.selectedImage = [UIImage imageNamed:@"cm2_btm_icn_discovery"];
        tabBarItem.title = @"发现音乐";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];

    }
    {
        UIViewController *vc = [MyMusicVC new];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        
        tabBarItem.image  = [UIImage imageNamed:@"cm2_btm_icn_music"];
        tabBarItem.selectedImage =   [UIImage imageNamed:@"cm2_btm_icn_music"];
        tabBarItem.title = @"我的音乐";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];
    }
    {
        UIViewController *vc = [FriendVC new];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        
        tabBarItem.image  = [UIImage imageNamed:@"cm2_btm_icn_friend"];
        tabBarItem.selectedImage =   [UIImage imageNamed:@"cm2_btm_icn_friend"];
        tabBarItem.title = @"朋友";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];
    }
    {
        UIViewController *vc = [AccountVC new];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        
        tabBarItem.image  = [UIImage imageNamed:@"cm2_btm_icn_account"];
        tabBarItem.selectedImage =   [UIImage imageNamed:@"cm2_btm_icn_account@3x"];
        tabBarItem.title = @"账号";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];
    }
    
    
    MyTabBarController *tabBarController = [MyTabBarController new];
    tabBarController.view.tintColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1];
    tabBarController.viewControllers = controllers.copy;
    tabBarController.hidesBottomBarWhenPushed = YES;
    tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:tabBarController animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
