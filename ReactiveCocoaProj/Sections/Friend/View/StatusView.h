//
//  StatusView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AVATOR_WIDTH 40
#define PADDING      10
#define NAME_HEIGHT  20
#define DATE_HEIGHT  10
#define MENU_BUTTON_WIDTH   20
#define MENU_ITEM_WIDTH     50
#define MENU_ITEM_HEIGHT    45
#define MENU_SPACE   30

#define NAME_FONT    9.f
#define DATE_FONT    6.f
#define CONTNTE_FONT 11.f
#define TAG_FONT     8.f
#define MENU_FONT    7.f

@interface MenuView : UIView
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UILabel  *rightLabel;
@end

@interface StatusView : UIView
@property(nonatomic, strong, readonly) UIButton *avatorButton;
@property(nonatomic, strong, readonly) UILabel  *nameLabel;
@property(nonatomic, strong, readonly) UILabel  *dateLabel;
@property(nonatomic, strong, readonly) UILabel  *contentLabel;
@property(nonatomic, strong, readonly) UILabel  *tagLabel;
@property(nonatomic, strong)           UIView   *contentView;
@property(nonatomic, strong, readonly) MenuView *likeButton;
@property(nonatomic, strong, readonly) MenuView *commentButton;
@property(nonatomic, strong, readonly) MenuView *repeatButton;
@property(nonatomic, strong, readonly) UIButton *optionButton;
@end

//视频分享视图
@interface VideoStatusView : StatusView
@property(nonatomic, strong) UIView *videoView;
@end

//单曲分享视图
@interface SongStatusView : StatusView
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) UIView         *song;
@end


