//
//  GoHorseCollectionViewCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/8.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "GoHorseCollectionViewCell.h"
#import "UIView+Layout.h"
@implementation GoHorseCollectionViewCell
+ (NSString *)reuseID {
    return @"GoHorseCollectionViewCell";
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.pageControl];
    }
    return self;
}

- (UIPageControl *)pageControl {
    if(!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 5;
        _pageControl.centerX = self.contentView.size.width/2;
        _pageControl.botton  = self.contentView.size.height;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

@end
