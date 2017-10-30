//
//  SUPlayerViewController.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SUPlayerViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *songs;
+ (instancetype)sharedInstance;
@end
