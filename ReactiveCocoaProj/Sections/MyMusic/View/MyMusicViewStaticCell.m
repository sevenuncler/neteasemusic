//
//  MyMusicViewStaticCell.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/2.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "MyMusicViewStaticCell.h"
#import "UIView+Layout.h"

@interface MyMusicViewStaticCell ()
@property (nonatomic, strong) UIView *customeAccessoryView;
@property (nonatomic, strong) UIImageView *arrowView;
@end

@implementation MyMusicViewStaticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.arrowView.centerY  = self.customeAccessoryView.centerY;
        self.arrowView.right    = self.customeAccessoryView.size.width;
        
        self.countLabel.centerY = self.arrowView.centerY;
        self.countLabel.right   = self.arrowView.left - 5;
        
        [self.customeAccessoryView addSubview:self.countLabel];
        [self.customeAccessoryView addSubview:self.arrowView];
        self.accessoryView = self.customeAccessoryView;
        
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.arrowView.centerY  = self.customeAccessoryView.centerY;
        self.arrowView.right    = self.customeAccessoryView.size.width;
        
        self.countLabel.centerY = self.arrowView.centerY;
        self.countLabel.right   = self.arrowView.left - 5;
        
        [self.customeAccessoryView addSubview:self.countLabel];
        [self.customeAccessoryView addSubview:self.arrowView];
        [self.contentView addSubview:self.customeAccessoryView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)customeAccessoryView {
    if(!_customeAccessoryView) {
        _customeAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.size.height)];
        _customeAccessoryView.right     = self.size.width;
        _customeAccessoryView.centerY   = self.size.height/2;
    }
    return _customeAccessoryView;
}

- (UILabel *)countLabel {
    if(!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.size.height)];
        _countLabel.text = @"999";
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (UIImageView *)arrowView {
    if(!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _arrowView.image = [UIImage imageNamed:@"cm2_list_icn_arr_fold"];
    }
    return _arrowView;
}


@end
