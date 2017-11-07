//
//  AccountVC.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/5.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUGeneralItem.h"
@interface AccountVC : UITableViewController
@property(nonatomic, strong) NSMutableArray<SUGeneralItem *> *items;
@end
