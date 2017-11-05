//
//  StatusCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/5.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "StatusCell.h"
#import "UIView+Layout.h"

@implementation StatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation SongViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.songStatusView];
    }
    return self;
}

- (SongStatusView *)songStatusView {
    if(!_songStatusView) {
        _songStatusView = [[SongStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _songStatusView;
}
@end

@implementation VideoViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.videoStatusView];
    }
    return self;
}

- (VideoStatusView *)videoStatusView {
    if(!_videoStatusView) {
        _videoStatusView = [VideoStatusView new];
    }
    return _videoStatusView;
}
@end
