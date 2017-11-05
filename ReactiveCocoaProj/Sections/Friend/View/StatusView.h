//
//  StatusView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"
#import <FLAnimatedImage/FLAnimatedImage.h>

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
#define LEFT_WIDTH 40
#define TITLE_FONT 10.f
#define SUB_TITLE_FONT 7.f

@interface SongView : UIView
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UILabel  *titleLabel;
@property(nonatomic, strong) UILabel  *subTitleLabel;
@end

#define IMAGE_SPACE 5
#define IMAGE_ITEM_PER_LINE 3
#define IMAGE_WIDTH ((SCREEN_WIDTH) - (AVATOR_WIDTH) - (3*PADDING) - ((IMAGE_ITEM_PER_LINE-1)*IMAGE_SPACE)) / (IMAGE_ITEM_PER_LINE)

@interface SongStatusView : StatusView
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) SongView       *songView;
@end


