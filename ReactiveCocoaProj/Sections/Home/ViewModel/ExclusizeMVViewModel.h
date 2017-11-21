//
//  ExclusizeMVViewModel.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/20.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExclusizeMVViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) dispatch_semaphore_t semaphore;
- (void)loadData;
@end
