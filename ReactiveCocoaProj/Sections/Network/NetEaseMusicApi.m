//
//  NetEaseMusicApi.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/15.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "NetEaseMusicApi.h"
#import "NSString+Encrypt.h"

static NSURLSession *session;
NSString *urlEncode(NSString *input);
// General
NSString *MODE = @"false";
NSString *MODULUS = @"00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b725152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbda92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe4875d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7";
NSString *NONCE = @"0CoJUm6Qyw8W8jud";
NSString *PUBKEY = @"010001";
NSString *VI = @"0102030405060708";
NSString *USERAGENT = @"NeteaseMusic 4.2.0/850 (iPhone; iOS 11.1; zh_CN)";
NSString *COOKIE = @"os=iPhone OS; osver=11.1; appver=4.2.0; deviceId=3e4725cb528001016e21203753c488ae";
NSString *REFERER = @"http://music.163.com/";
// use static secretKey, without RSA algorithm
NSString *secretKey = @"TA3YiYCfY2dDJQgg";
NSString *encSecKey = @"84ca47bca10bad09a6b04c5c927ef077d9b9f1e37098aa3eac6ea70eb59df0aa28b691b7e75e4f1f9831754919ea784c8f74fbfadf2898b0be17849fd656060162857830e241aba44991601f137624094c114ea8d17bce815b0cd4e5b8e2fbaba978c6d1d14dc3d1faf852bdd28818031ccdaaa13a6018e1024e2aae98844210";


NSString * const HOST = @"";
@implementation NetEaseMusicApi
{
    
}

+ (void)initialize {
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

/**
 登录
 */
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    
    NSString *passwordMD5 = [password md5];
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{
                                                             @"phone":username,
                                                             @"password":passwordMD5,
                                                             @"rememberLogin":@"true"
                                                             } options:NSJSONWritingPrettyPrinted error:nil];
//    data = [NSString aesWithData:data withKey:NONCE];
//    data = [NSString aesWithData:data withKey:secretKey];
//    NSString *params = [self convertDataToHexStr:data];
//    NSData *dataBody = [NSJSONSerialization dataWithJSONObject:@{
//                                                                 @"params": params,
//                                                                 @"encSecKey":encSecKey
//                                                                 } options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *urlString = @"http://10.240.76.186:3000/login/cellphone";
    urlString = [NSString stringWithFormat:@"%@?phone=%@&password=%@", urlString, username, password];
    NSMutableURLRequest *request = [self requestWithURLString:urlString];
    
    
    request.HTTPBody = data;
    request.HTTPMethod = @"GET";
//    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"gzip,deflate,sdch" forHTTPHeaderField:@"Accept-Encoding"];
//    [request setValue:@"music.163.com" forHTTPHeaderField:@"host"];
//    [request setValue:@"appver=1.5.3;" forHTTPHeaderField:@"Cookie"];
//    [request setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}


/**
 搜索
 */
+ (void)searchWithQuery:(NSString *)query type:(NMSearchType)type offset:(NSInteger)offset limit:(NSInteger)limit completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *HTTPBody = [NSString stringWithFormat:@"s=%@&type=%ld&offset=%ld&limit=%ld", urlEncode(query), type, offset, limit];
    NSMutableURLRequest *request = [self requestWithURLString:@"http://music.163.com/api/search/pc"];
    request.HTTPBody = [HTTPBody dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

/**
 获取音乐信息
 */
+ (void)musicInfoWithId:(NSInteger)musicId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *ids = [NSString stringWithFormat:@"[%ld]", musicId];
    NSString *parameters = [NSString stringWithFormat:@"id=%ld&ids=%@", musicId, urlEncode(ids)];
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/song/detail?%@", parameters];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

/**
 获取歌手专辑列表
 */
+ (void)artistAlbumWithArtistId:(NSInteger)artistId limit:(NSInteger)limit completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/artist/albums/%ld?limit=%ld", artistId, limit];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

/**
 专辑信息
 */
+ (void)albumInfoWithAlbumId:(NSInteger)albumId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/album/%ld", albumId];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

/**
 歌单
 */
+ (void)playlistInfoWithPlaylistId:(NSInteger)playlistId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/playlist/detail?id=%ld", playlistId];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

/**
 歌词
 */
+ (void)musicLyricWithMusicId:(NSInteger)musicId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/song/lyric?os=pc&id=%ld&lv=-1&kv=-1&tv=-1", musicId];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

/**
 MV信息
 */
+ (void)newRecommandSongWithCompletionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/weapi/v2/banner/get"];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

//
+ (void)mvInfoWithMvID:(NSInteger)mvId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/mv/detail?id=%ld&type=mp4", mvId];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}

+ (void)programInfoWithProgramId:(NSInteger)programId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler {
    NSString *URLString = [NSString stringWithFormat:@"http://music.163.com/api/dj/program/detail?id=%ld", programId];
    NSMutableURLRequest *request = [self requestWithURLString:URLString];
    request.HTTPMethod = @"GET";
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
}


/**
 初始化请求对象
 
 @param URLString <#URLString description#>
 
 @return <#return value description#>
 */
+ (NSMutableURLRequest *)requestWithURLString:(NSString *)URLString {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [request setValue:@"appver=2.0.2" forHTTPHeaderField:@"Cookie"];
    request.HTTPShouldHandleCookies = NO;
    return request;
}



NSString *urlEncode(NSString *input) {
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return outputStr;
}

@end
