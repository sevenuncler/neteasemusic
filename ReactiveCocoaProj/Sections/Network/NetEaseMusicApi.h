//
//  NetEaseMusicApi.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/15.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//  注意注意注意，本文件来自https://github.com/cezres/NeteaseMusicAPI/blob/master/NeteaseMusicAPI.h，感谢这位同志

#import <Foundation/Foundation.h>

typedef void (^NeteaseMusicAPICompletionHandler)(NSData * data, NSURLResponse * response, NSError * error);
#define NMSearch(name,value) NMSearch_ ## name = value
/**
 网易云音乐-搜索-类型
 
 - Music:    单曲
 - Album:    专辑
 - Singer:   歌手
 - PlayList: 歌单
 - User:     用户
 - Mv:       MV
 - Lyric:    歌词
 - Radio:    电台
 */
typedef NS_ENUM(NSInteger, NMSearchType) {
    NMSearch(Music, 1),
    NMSearch(Album, 10),
    NMSearch(Singer, 100),
    NMSearch(PlayList, 1000),
    NMSearch(User, 1002),
    NMSearch(Mv, 1004),
    NMSearch(Lyric, 1006),
    NMSearch(Radio, 1009),
};
@interface NetEaseMusicApi : NSObject

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;
/**
 搜索
 @param query             <#query description#>
 @param type              <#type description#>
 @param offset            <#offset description#>
 @param limit             <#limit description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)searchWithQuery:(NSString *)query type:(NMSearchType)type offset:(NSInteger)offset limit:(NSInteger)limit completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;


/**
 获取音乐信息
 
 @param musicId           <#musicId description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)musicInfoWithId:(NSInteger)musicId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

/**
 获取歌手专辑列表
 
 @param artistId          <#artistId description#>
 @param limit             <#limit description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)artistAlbumWithArtistId:(NSInteger)artistId limit:(NSInteger)limit completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

/**
 专辑信息
 
 @param albumId           <#albumId description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)albumInfoWithAlbumId:(NSInteger)albumId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

/**
 歌单信息
 
 @param playlistId        <#playlistId description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)playlistInfoWithPlaylistId:(NSInteger)playlistId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

/**
 MV
 @param mvId              <#mvId description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)mvInfoWithMvID:(NSInteger)mvId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

/**
 歌词
 
 @param musicId           <#musicId description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)musicLyricWithMusicId:(NSInteger)musicId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

/**
 电台节目信息
 @param programId         <#programId description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)programInfoWithProgramId:(NSInteger)programId completionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;

+ (void)newRecommandSongWithCompletionHandler:(NeteaseMusicAPICompletionHandler)completionHandler;


@end
