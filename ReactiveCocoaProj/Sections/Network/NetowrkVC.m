//
//  NetowrkVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/13.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "NetowrkVC.h"
#import "WeiboSDK.h"
#import "NetEaseMusicApi.h"

NSURLSession *session;

@interface NetowrkVC ()<WeiboSDKDelegate, UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString  *code;
@end

@implementation NetowrkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNeteaseMusicApi];
    [NetEaseMusicApi artistAlbumWithArtistId:12000103 limit:10 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"请求出错 %@", error);
        }
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回结果1:%@", string);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"返回结果2: \n%@", dict);
    }];
}

- (void)getAList {
    
}

- (void)setUpNeteaseMusicApi {
    NSString *urlString = @"http://s.music.163.com/search/get/?s=周杰伦&limit=10&type=1";
    //获取歌单
//    urlString = @"http://music.163.com/api/playlist/detail?id=387699584";
    //私人FM
//    urlString = @"http://music.163.com/api/radio/get";
//    urlString = @"http://music.163.com/discover/toplist?id=3779629";
//    urlString = @"http://music.163.com/api/song/lyric/";
    NSString *utf8String = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:utf8String] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip,deflate,sdch" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"music.163.com" forHTTPHeaderField:@"host"];
    [request setValue:@"appver=1.5.3;" forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"orpheus://orpheus" forHTTPHeaderField:@"Origin"];
    [request setValue:@"807" forHTTPHeaderField:@"Content-Length"];
//    NSDictionary *property = [NSDictionary dictionaryWithObjectsAndKeys:@"1.5.3",@"appver", nil];
//    NSHTTPCookie *cookie   = [NSHTTPCookie cookieWithProperties:property];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{
                                                                 @"s":@"a",
                                                                 @"sub":@"false",
                                                                 @"offset":@"1",
                                                                 @"limit":@"5",
                                                                 @"total":@"true",
                                                                 @"type":@"1"} options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody    = jsonData;
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            NSLog(@"请求出错 %@", error);
        }
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回结果1:%@", string);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"返回结果2: \n%@", dict);
    }];
    [dataTask resume];
}


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
