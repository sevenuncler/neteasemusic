//
//  StatusView.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "StatusView.h"
#import "UIView+Layout.h"
#import "SUImageManager.h"

@implementation MenuView

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.leftButton];
        [self addSubview:self.rightLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftButton.left    = 0;
    self.leftButton.centerY = self.size.height/2;
    
    [self.rightLabel sizeToFit];
    self.rightLabel.left    = self.leftButton.right + PADDING;
    self.rightLabel.centerY = self.leftButton.centerY;
}

- (UIButton *)leftButton {
    if(!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.size = CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_WIDTH);
        [_leftButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UILabel *)rightLabel {
    if(!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.text = @"999";
        _rightLabel.font = [UIFont systemFontOfSize:MENU_FONT];
    }
    return _rightLabel;
}
@end

@implementation StatusView
@synthesize avatorButton = _avatorButton;
@synthesize nameLabel    = _nameLabel;
@synthesize dateLabel    = _dateLabel;
@synthesize contentLabel = _contentLabel;
@synthesize tagLabel     = _tagLabel;
@synthesize likeButton   = _likeButton;
@synthesize commentButton= _commentButton;
@synthesize repeatButton = _repeatButton;
@synthesize contentView  = _contentView;
@synthesize optionButton = _optionButton;

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(255, 250, 255);
        [self addSubview:self.avatorButton];
        [self addSubview:self.dateLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.contentView];
        [self addSubview:self.tagLabel];
        [self addSubview:self.likeButton];
        [self addSubview:self.commentButton];
        [self addSubview:self.repeatButton];
        [self addSubview:self.optionButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.nameLabel sizeToFit];
    self.nameLabel.left = self.avatorButton.right + PADDING;
    
    [self.dateLabel sizeToFit];
    self.dateLabel.left = self.nameLabel.left;
    self.dateLabel.top  = self.nameLabel.botton + PADDING;
    
    CGSize size = [self.contentLabel sizeThatFits:CGSizeMake(self.size.width - self.nameLabel.left - PADDING, CGFLOAT_MAX)];
    self.contentLabel.size = size;
    self.contentLabel.left = self.nameLabel.left;
    self.contentLabel.top  = self.dateLabel.botton + 2*PADDING;
    
    self.contentView.left = self.contentLabel.left;
    self.contentView.top  = self.contentLabel.botton + PADDING;
    
    [self.tagLabel sizeToFit];
    self.tagLabel.left = self.contentView.left;
    self.tagLabel.top  = self.contentView.botton + PADDING;
    
    self.likeButton.left        = self.contentLabel.left;
    self.likeButton.top         = self.tagLabel.botton + 2*PADDING;
    
    self.commentButton.left     = self.likeButton.right + MENU_SPACE;
    self.commentButton.centerY  = self.likeButton.centerY;
    
    self.repeatButton.left      = self.commentButton.right + MENU_SPACE;
    self.repeatButton.centerY   = self.commentButton.centerY;
    
    self.optionButton.right     = self.size.width - PADDING;
    self.optionButton.centerY   = self.repeatButton.centerY;
    
    self.size = CGSizeMake(self.size.width, self.likeButton.botton) ;
}

- (UIButton *)avatorButton {
    if(!_avatorButton) {
        _avatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatorButton.size = CGSizeMake(AVATOR_WIDTH, AVATOR_WIDTH);
        _avatorButton.imageView.layer.cornerRadius = AVATOR_WIDTH/2;
        _avatorButton.left = PADDING;
        _avatorButton.top  = PADDING;
        [_avatorButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _avatorButton;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:NAME_FONT];
        _nameLabel.top  = PADDING;
        _nameLabel.text = @"人类蠕动精华";
    }
    return _nameLabel;
}

- (UILabel *)dateLabel {
    if(!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:DATE_FONT];
        _dateLabel.text = @"11月4日";
    }
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:CONTNTE_FONT];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"彼得四年三月，突尼斯节度使，侍都督亚历山大并开罗三洲诸护军贝都中郎将、独立了木刺史、北非往后摩尔，顿首死罪，上书";
    }
    return _contentLabel;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (void)setContentView:(UIView *)contentView {
    if(_contentView != contentView) {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        [self addSubview:_contentView];
        [self setNeedsLayout];
    }
}

- (UILabel *)tagLabel {
    if(!_tagLabel) {
        _tagLabel = [UILabel new];
        _tagLabel.font = [UIFont systemFontOfSize:TAG_FONT];
        _tagLabel.text = @"—— 来这里了解影评资讯";
    }
    return _tagLabel;
}

- (MenuView *)likeButton {
    if(!_likeButton) {
        _likeButton = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, MENU_ITEM_WIDTH, MENU_ITEM_HEIGHT)];
    }
    return _likeButton;
}

- (MenuView *)commentButton {
    if(!_commentButton) {
        _commentButton = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, MENU_ITEM_WIDTH, MENU_ITEM_HEIGHT)];
    }
    return _commentButton;
}

- (MenuView *)repeatButton {
    if(!_repeatButton) {
        _repeatButton = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, MENU_ITEM_WIDTH, MENU_ITEM_HEIGHT)];
    }
    return _repeatButton;
}

- (UIButton *)optionButton {
    if(!_optionButton) {
        _optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_optionButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
        _optionButton.size = CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_WIDTH);
    }
    return _optionButton;
}

@end

@implementation VideoStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.contentView = self.videoView;
    }
    return self;
}

- (UIView *)videoView {
    if(!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, SCREEN_WIDTH - 200)];
        _videoView.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    }
    return _videoView;
}

@end

@implementation SongView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);;
        [self addSubview:self.leftButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [self.titleLabel sizeToFit];
    
    self.leftButton.left     = PADDING;
    self.leftButton.centerY  = self.size.height/2;
    
    self.titleLabel.top  = PADDING;
    self.titleLabel.left = self.leftButton.right + PADDING;
    
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.left = self.titleLabel.left;
    self.subTitleLabel.top  = self.titleLabel.botton + PADDING;
}

- (UIButton *)leftButton {
    if(!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.size = CGSizeMake(LEFT_WIDTH, LEFT_WIDTH);
//        [_leftButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT];
        _titleLabel.text = @"终身美丽（电影《瘦身男女》主题曲）";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if(!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = [UIFont systemFontOfSize:SUB_TITLE_FONT];
        _subTitleLabel.text = @"郑秀文";
    }
    return _subTitleLabel;
}

@end

@interface SongStatusView()
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) NSMutableArray *imageViews;
@end

@implementation SongStatusView
- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.contentView = self.containerView;
    }
    return self;
}

- (void)layoutSubviews {
    __weak typeof(self) weakSelf = self;
    
    self.containerView.size = CGSizeMake(self.containerView.size.width, 0);
    [self.imageViews enumerateObjectsUsingBlock:^(FLAnimatedImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
        obj.size   = CGSizeZero;
    }];

    [self.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx >= weakSelf.imageViews.count) {
            FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
            [self.imageViews addObject:imageView];
            imageView.image = [UIImage imageNamed:@"image"];
            [weakSelf.containerView addSubview:imageView];
        }
        FLAnimatedImageView *iv = [self.imageViews objectAtIndex:idx];
        iv.size = CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH);
        NSUInteger row = idx / IMAGE_ITEM_PER_LINE;
        NSUInteger col = idx % IMAGE_ITEM_PER_LINE;
        iv.left = col * (IMAGE_WIDTH + IMAGE_SPACE);
        iv.top  = row * (IMAGE_WIDTH + IMAGE_SPACE);
        iv.hidden = NO;
        SUImageManager *imageManager = [SUImageManager defaultImageManager];
        @weakify(iv);
        [[imageManager imageWithUrl:obj] subscribeNext:^(UIImage *x) {
            @strongify(iv);
            iv.image = x;
        }];
    }];
    if(self.images.count>0) {
        FLAnimatedImageView *iv = [self.imageViews objectAtIndex:self.images.count-1];
        self.containerView.size   = CGSizeMake(self.containerView.size.width, iv.botton + PADDING);
    }
    if(!self.songView.hidden) {
        self.songView.left = 0;
        self.songView.top  = self.containerView.size.height;
        self.containerView.size = CGSizeMake(self.containerView.size.width, self.songView.botton + PADDING);
    }
    [super layoutSubviews];
}

- (NSMutableArray *)images {
    if(!_images) {
        _images = [NSMutableArray arrayWithCapacity:9];
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
        {
            [_images addObject:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=756514221,687352746&fm=27&gp=0.jpg"];
        }
    }
    return _images;
}

- (UIView *)containerView {
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _containerView;
}

- (NSMutableArray *)imageViews {
    if(!_imageViews) {
        _imageViews = [NSMutableArray arrayWithCapacity:9];
        
    }
    return _imageViews;
}

- (SongView *)songView {
    if(!_songView) {
        _songView = [[SongView alloc] initWithFrame:CGRectMake(0, 0, IMAGE_ITEM_PER_LINE*IMAGE_WIDTH + IMAGE_SPACE*(IMAGE_ITEM_PER_LINE-1), LEFT_WIDTH+2*PADDING)];
        [self.containerView addSubview:_songView];
    }
    return _songView;
}




@end
