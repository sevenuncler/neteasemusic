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
#import "WeiboSDK.h"

@interface AdVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString  *code;
@end

@implementation AdVC
- (void)setUpSinaWeibo {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"293640916"];
    WBAuthorizeRequest *authRequest = [[WBAuthorizeRequest alloc] init];
    authRequest.redirectURI = @"https://www.baidu.com";
    //    authRequest.scope = @"all";
    authRequest.shouldShowWebViewForAuthIfCannotSSO = NO;
    [WeiboSDK sendRequest:authRequest];
//
    
    //
//    WBMessageObject *messageObject = [WBMessageObject message];
//    messageObject.text = @"api数据测试";
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject];
//    [WeiboSDK sendRequest:request];
//    [WeiboSDK linkToUser:@"5655398558"];

//    [WeiboSDK linkToSingleBlog:@"5655398558" blogID:@"FaXBjmAPa"];

}

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
    NSString *urlString = @"https://api.weibo.com/oauth2/authorize?client_id=293640916&response_type=code&redirect_uri=https://www.baidu.com";
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3];
//    [webView loadRequest:mutableRequest];

    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
        NSLog(@"授权结果 :%@\n :%@\n :%@\n :%@",response, dict, error, string);
//        NSMutableString *urlString = [NSMutableString stringWithString:string];
//        string = [urlString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

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
    NSRange range = [url.absoluteString rangeOfString:@"code="];
    if(range.length>0) {
    NSString *code = [url.absoluteString substringFromIndex:range.location+5];
        NSLog(@"code>>>%@", code);
        self.code = code;
        //获取token
        NSString *url      = @"https://api.weibo.com/oauth2/access_token";
        NSString *clientID = @"293640916";
        NSString *redirect = @"https://www.baidu.com";
        NSString *secret   = @"b8f1c825107074eb40d0428f6c03d541";
        NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@", url, clientID, secret, code, redirect];
        NSMutableURLRequest *requestToken = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        requestToken.HTTPMethod = @"post";
        [requestToken setValue:clientID forHTTPHeaderField:@"client_id"];
        [requestToken setValue:secret forHTTPHeaderField:@"client_secret"];
        [requestToken setValue:@"authorization_code" forHTTPHeaderField:@"grant_type"];
        [requestToken setValue:code forHTTPHeaderField:@"code"];
        [requestToken setValue:redirect forHTTPHeaderField:@"redirect_uri"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestToken completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *token = dict[@"access_token"];
            NSLog(@">>>>%@\n%@\n%@", response, error, string);
            
//            https://api.weibo.com/2/search/topics.json
            NSString *q = @"吴亦凡";
            NSString *count = @"10";
            NSString *page  = @"1";
            NSString *url = @"https://api.weibo.com/2/statuses/public_timeline.json";
            NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@&q=%@&count=%@&page=%@", url, token,q, count, page];
            NSString *utf8String = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *requestApi = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:utf8String]];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestApi completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@">>>>%@\n%@\n%@", response, error, string);
            }] ;
            [dataTask resume];
        }];
        [dataTask resume];
    }
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

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
}

@end
