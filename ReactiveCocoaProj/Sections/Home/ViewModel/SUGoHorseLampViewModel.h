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

@interface SUGoHorseLampViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray    *items;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) RACSubject        *timerSignal;
@property (nonatomic, assign) Class             *registerClz;

+ (NSString *)reuseID;
- (void)startTimer;
- (void)pauseTimer;


@end
