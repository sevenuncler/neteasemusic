//
//  CatagoryView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/24.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "CatagoryView.h"
#import "UIView+Layout.h"
#import "Macros.h"

@implementation CatagoryView
@synthesize segmentedControl = _segmentedControl;
@synthesize underLine        = _underLine;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame];
    if(self) {
        self.items = items.copy;
        self.tintColor = [UIColor clearColor];
        [self addSubview:self.segmentedControl];
        [self insertSubview:self.underLine aboveSubview:self.segmentedControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.segmentedControl.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    self.underLine.size         = CGSizeMake(40, 2);
    self.underLine.botton       = self.segmentedControl.botton;
    self.underLine.centerX = 60;
}

- (UISegmentedControl *)segmentedControl {
    if(_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
        _segmentedControl.tintColor = [UIColor clearColor];
        NSDictionary *normalAttribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]};
        [_segmentedControl setTitleTextAttributes:normalAttribute forState:UIControlStateNormal];
        NSDictionary *selectedAttribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor redColor]};
        [_segmentedControl setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    }
    return _segmentedControl;
}

- (UIView *)underLine {
    if(!_underLine) {
        _underLine = [UIView new];
        _underLine.backgroundColor = [UIColor redColor];
    }
    return _underLine;
}

@end
