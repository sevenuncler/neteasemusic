//
//  SUGoHorseLampViewModel.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class SUBannerItem;
typedef void(^ScrollViewIndexHandler)(NSIndexPath *idx);
@interface SUGoHorseLampViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray<SUBannerItem *>    *items;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) RACSubject        *timerSignal;
@property (nonatomic, assign) Class             *registerClz;
@property (nonatomic, strong) NSMutableArray<RACDisposable *> *disposes;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy)   ScrollViewIndexHandler indexHandler;

+ (NSString *)reuseID;
- (void)startTimer;
- (void)pauseTimer;


@end
