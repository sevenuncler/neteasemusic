//
//  SUSongListTopView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const kPadding       = 10;
static CGFloat const kCoverSize     = 120;
static CGFloat const kMenuSize      = 25;
static CGFloat const kAvatorSize    = 30;
static CGFloat const kFontSize      = 10;

@interface SUSongListTopView : UIView

@property(nonatomic, strong, readonly) UIImageView *coverIV;
@property(nonatomic, strong, readonly) UIImageView *avatorIV;
@property(nonatomic, strong, readonly) UILabel     *nameLabel;
@property(nonatomic, strong, readonly) UILabel     *likedNumLabel;
@property(nonatomic, strong, readonly) UILabel     *commentNumLabel;
@property(nonatomic, strong, readonly) UILabel     *trandNumLabel;

@end
