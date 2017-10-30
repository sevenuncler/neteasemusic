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

@interface CatagoryView()

@property (nonatomic, strong) RACSubject *selectIndexSignal;

@end

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
    self.underLine.size         = CGSizeMake(45, 2);
    self.underLine.botton       = self.segmentedControl.botton;
    _underLine.centerX          = SCREEN_WIDTH / self.items.count * (self.segmentedControl.selectedSegmentIndex + 0.5);
}

- (void(^)(CGFloat))underLineProgress {
    return ^void(CGFloat progress) {
        CGFloat itemWidth = SCREEN_WIDTH / self.items.count;
        self.underLine.centerX = itemWidth * (0.5 + progress);
        if(progress<=0.5) {
            self.segmentedControl.selectedSegmentIndex = 0;
        }else if(0.5<progress && progress<=1.5) {
            self.segmentedControl.selectedSegmentIndex = 1;
        }else if(1.5<progress &&progress<=2) {
            self.segmentedControl.selectedSegmentIndex = 2;
        }
    };
}

- (RACSignal *)selectedIndexSignal {
    return self.selectIndexSignal;
}

- (void)onSelectedAction:(UISegmentedControl *)sender {
    NSInteger idx = sender.selectedSegmentIndex;
//    self.underLine.centerX = SCREEN_WIDTH / self.items.count * (idx + 0.5);
    [self.selectIndexSignal sendNext:@(idx)];
}

- (UISegmentedControl *)segmentedControl {
    if(_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:self.items];
        _segmentedControl.tintColor = [UIColor clearColor];
        NSDictionary *normalAttribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        [_segmentedControl setTitleTextAttributes:normalAttribute forState:UIControlStateNormal];
        NSDictionary *selectedAttribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]};
        [_segmentedControl setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
        [_segmentedControl addTarget:self action:@selector(onSelectedAction:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;

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

- (RACSubject *)selectIndexSignal {
    if(!_selectIndexSignal) {
        _selectIndexSignal = [RACSubject subject];
    }
    return _selectIndexSignal;
}

@end
