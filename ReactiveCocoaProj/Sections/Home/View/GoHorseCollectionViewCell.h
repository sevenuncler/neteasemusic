//
//  GoHorseCollectionViewCell.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/8.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "ReuseCollectionViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GoHorseCollectionViewCell : ReuseCollectionViewCell
@property (nonatomic, strong) UIPageControl *pageControl;
+ (NSString *)reuseID;
@end
