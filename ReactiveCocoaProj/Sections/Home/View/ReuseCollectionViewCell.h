//
//  ReuseCollectionViewCell.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReuseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

+ (NSString *)reuseID;

@end
