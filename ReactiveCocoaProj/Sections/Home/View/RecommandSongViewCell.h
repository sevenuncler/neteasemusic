//
//  RecommandSongViewCell.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface RecommandSongViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView *coverImageView;
@property (nonatomic, strong, readonly) UILabel     *titleLabel;
@property (nonatomic, strong, readonly) UILabel     *listenedLabel;
@property (nonatomic, strong, readonly) UILabel     *subTitleLabel;

@end
NS_ASSUME_NONNULL_END
