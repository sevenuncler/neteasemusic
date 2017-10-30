//
//  ReuseCollectionViewCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "ReuseCollectionViewCell.h"
#import "UIView+Layout.h"

@implementation ReuseCollectionViewCell
@synthesize collectionView = _collectionView;

+ (NSString *)reuseID {
    return @"reuseCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.size = self.size;
}

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator   = NO;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

@end
