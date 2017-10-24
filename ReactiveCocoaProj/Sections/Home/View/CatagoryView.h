//
//  CatagoryView.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/24.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatagoryView : UIView

@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;
@property (nonatomic, strong, readonly) UIView             *underLine;
@property (nonatomic, copy)             NSArray            *items;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

@end
