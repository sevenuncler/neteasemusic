//
//  Animator.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/14.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)sharedAnimator;

@end