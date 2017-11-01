//
//  RecommandSongViewModel.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/22.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RecommandSongViewModel : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *items;

- (void)loadData;

@end
