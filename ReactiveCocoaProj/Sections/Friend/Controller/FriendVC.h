//
//  FriendVC.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusItem.h"

@interface FriendVC : UITableViewController
@property(nonatomic, strong) NSMutableArray<StatusItem *> *items;
@end
