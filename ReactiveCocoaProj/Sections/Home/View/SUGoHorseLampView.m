//
//  SUGoHorseLampView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUGoHorseLampView.h"
#import "SUGoHorseLampCell.h"


@interface SUGoHorseLampView()

@property (nonatomic, strong) dispatch_source_t          timer;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SUGoHorseLampView
- (void)layoutSubviews {
    [super layoutSubviews];
    self.flowLayout.itemSize = self.frame.size;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [self initWithFrame:frame collectionViewLayout:self.flowLayout]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if(self = [super initWithFrame:frame collectionViewLayout:layout]) {
        static NSString * const reuseID = @"goHorseCell";
        [self registerClass:[SUGoHorseLampCell class] forCellWithReuseIdentifier:reuseID];
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            
        });
        dispatch_resume(_timer);
        self.pagingEnabled = YES;
    }
    return self;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if(!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing      = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}




@end
