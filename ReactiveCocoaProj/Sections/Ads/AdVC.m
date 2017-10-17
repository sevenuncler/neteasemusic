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
#import "ViewController.h"

@interface AdVC ()

@end

@implementation AdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:@"jhht.jpg"];
    [self.view addSubview:imageView];
    [self performSelector:@selector(transiteMainVC:) withObject:nil afterDelay:3];
}

- (void)transiteMainVC:(id)sender {
    NSMutableArray *controllers = @[].mutableCopy;
    {
        UIViewController *vc = [[SUHomeVC alloc] init];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        tabBarItem.image = [[UIImage imageNamed:@"image"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.selectedImage = [[UIImage imageNamed:@"image"] imageWithSize:CGSizeMake(30, 30)];
        tabBarItem.title = @"发现音乐";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navi];
        
    }
    {
        UIViewController *vc = [ViewController new];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        
        tabBarItem.image  = [[UIImage imageNamed:@"generic_img"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.selectedImage =   [[UIImage imageNamed:@"generic_img"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.title = @"我的音乐";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];
    }
    {
        UIViewController *vc = [ViewController new];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        
        tabBarItem.image  = [[UIImage imageNamed:@"generic_img"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.selectedImage =   [[UIImage imageNamed:@"generic_img"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.title = @"朋友";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];
    }
    {
        UIViewController *vc = [ViewController new];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
        
        tabBarItem.image  = [[UIImage imageNamed:@"generic_img"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.selectedImage =   [[UIImage imageNamed:@"generic_img"] imageWithSize:CGSizeMake(25, 25)];
        tabBarItem.title = @"账号";
        vc.tabBarItem = tabBarItem;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:navigationController];
    }
    
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.view.tintColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1];
    tabBarController.viewControllers = controllers.copy;
    UINavigationController *mainNaviController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    mainNaviController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:mainNaviController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
