//
//  NetEaseMusic.h
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NeteaseMusicCompletionHandler)(NSData * data, NSURLResponse * response, NSError * error);

@interface NetEaseMusic : NSObject

+ (void)bannerWithComplection:(NeteaseMusicCompletionHandler )complectionHandler;
+ (void)highQualityPlayListWithComplection:(NeteaseMusicCompletionHandler)complectionHandler;
+ (void)playListDetailWithID:(NSString *)plid complection:(NeteaseMusicCompletionHandler)complectionHandler;
+ (void)songDetailWithID:(NSString *)songID complection:(NeteaseMusicCompletionHandler)complectionHandler;
+ (void)songURLWithID:(NSString *)songIDs complection:(NeteaseMusicCompletionHandler)complectionHandler;
@end
