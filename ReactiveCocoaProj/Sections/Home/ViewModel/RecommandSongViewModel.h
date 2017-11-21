//
//  RecommandSongViewModel.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PersonalizedItem.h"

@interface InterModel : NSObject
@property (nonatomic,copy) NSArray<PersonalizedItem *> *playLists;
@end

@interface RecommandSongViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) InterModel     *interModel;

- (void)loadData;

@end
