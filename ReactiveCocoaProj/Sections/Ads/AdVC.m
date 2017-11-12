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

@interface AdVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation AdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:@"jhht.jpg"];
    [self.view addSubview:imageView];
//    [self performSelector:@selector(transiteMainVC:) withObject:nil afterDelay:0];
    [self loadNetworkData];
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


- (void)loadNetworkData {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.delegate = self;
    [self.view addSubview:webView];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=293640916&response_type=code&redirect_uri=https://www.baidu.com"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
        NSLog(@"授权结果 :%@\n :%@\n :%@\n :%@",response, dict, error, string);
//        NSMutableString *urlString = [NSMutableString stringWithString:string];
//        string = [urlString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        dispatch_async(dispatch_get_main_queue(), ^{
            [webView loadHTMLString:string baseURL:nil];
        });
    }];
    [dataTask resume];
//    webView load
    //https://api.weibo.com/oauth2/authorize?client_id=293640916&response_type=code&redirect_uri=https://open.weibo.cn/oauth2/authorize
    //https://api.weibo.com/oauth2/access_token?client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE
//    [webView loadRequest:mutableRequest];

    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    NSLog(@"WebViewDelegate %@ %@", request, url);

    if([url.scheme isEqualToString:@"about"]) {
        return NO;
    }
    return YES;
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
