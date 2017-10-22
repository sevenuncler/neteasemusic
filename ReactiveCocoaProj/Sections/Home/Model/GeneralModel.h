//
//  GeneralModel.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Layout.h"

@interface GeneralModel : NSObject

@property (nonatomic, strong) id<UICollectionViewDelegate, UICollectionViewDataSource> viewModel;
@property (nonatomic, copy)   NSString *reuseID;
@property (nonatomic, strong) Layout   *layout;

@end
