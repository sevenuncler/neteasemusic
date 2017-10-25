//
//  PlayerView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerLongPlaying
{
    dispatch_source_t timer;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self.container addSubview:self.albumsCover];
        [self addSubview:self.container];
    }
    return self;
}

- (void)start {
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    static CGFloat angle = M_PI_4/2;
    dispatch_source_set_event_handler(timer, ^{
        
        self.container.transform = CGAffineTransformMakeRotation(angle);
        angle += M_PI_4/50;
    });
    dispatch_resume(timer);
}

- (void)stop {
    dispatch_suspend(timer);
}

- (UIImageView *)albumsCover {
    if(!_albumsCover) {
        _albumsCover = [[UIImageView alloc] init];
        _albumsCover.frame = CGRectMake(0, 0, 20, 20);
        _albumsCover.image = [UIImage imageNamed:@"image"];
    }
    return _albumsCover;
}

- (UIImageView *)container {
    if(!_container) {
        _container = [[UIImageView alloc] initWithFrame:self.bounds];
        _container.image = [UIImage imageNamed:@"cm2_play_disc"];
    }
    return _container;
}

@end

@implementation PlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
