//
//  TransitionManager.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/14.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TransitionManager : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) id <UIViewControllerAnimatedTransitioning> animator;

@end
