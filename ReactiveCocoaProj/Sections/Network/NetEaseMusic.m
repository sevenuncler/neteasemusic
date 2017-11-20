//
//  NetEaseMusic.m
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "NetEaseMusic.h"

static NSString * const HOST = @"http://10.240.76.186:3000";
static NSURLSession *session;
@interface NetEaseMusic ()

@end

@implementation NetEaseMusic

#pragma mark - Public API

+ (void)bannerWithComplection:(NeteaseMusicCompletionHandler)complectionHandler {
    NSString *path = @"/banner";
    [self commonRequestWithPath:path complection:complectionHandler];
}

+ (void)highQualityPlayListWithComplection:(NeteaseMusicCompletionHandler)complectionHandler {
    NSString *path = @"/top/playlist/highquality";
    [self commonRequestWithPath:path complection:complectionHandler];
}

+ (void)playListDetailWithID:(NSString *)plid complection:(NeteaseMusicCompletionHandler)complectionHandler {
    NSString *path = @"/playlist/detail";
    path = [NSString stringWithFormat:@"%@?id=%@", path, plid];
    [self commonRequestWithPath:path complection:complectionHandler];
}

+ (void)songDetailWithID:(NSString *)songID complection:(NeteaseMusicCompletionHandler)complectionHandler {
    NSString *path = @"/song/detail";
    path = [NSString stringWithFormat:@"%@?ids=%@", path, songID];
    [self commonRequestWithPath:path complection:complectionHandler];
}

+ (void)songURLWithID:(NSString *)songIDs complection:(NeteaseMusicCompletionHandler)complectionHandler {
    NSString *path = @"/music/url";
    path = [NSString stringWithFormat:@"%@?id=%@", path, songIDs];
    [self commonRequestWithPath:path complection:complectionHandler];
}

+ (void)commonRequestWithPath:(NSString *)path complection:(NeteaseMusicCompletionHandler)complectionHandler{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", HOST, path];
    [[self.session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:complectionHandler] resume];
}

+ (NSURLSession *)session {
    if(nil == session) {
        session = [NSURLSession sharedSession];
    }
    return session;
}

@end
