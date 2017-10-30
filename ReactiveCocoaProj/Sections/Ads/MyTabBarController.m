//
//  MyTabBarController.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "MyTabBarController.h"
#import "SUPlayerViewController.h"
@interface MyTabBarController ()
@property (nonatomic, strong) SUPlayerViewController *playerVC;
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cm2_topbar_icn_playing_prs"] style:UIBarButtonItemStylePlain target:self action:@selector(onPlayerAction:)];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cm2_topbar_icn_mic_prs"] style:UIBarButtonItemStylePlain target:self action:@selector(onSongRecoginzeAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

}

- (void)onSongRecoginzeAction:(id)sender {
    
}

- (void)onPlayerAction:(id)sender {
    [self.navigationController pushViewController:self.playerVC animated:YES];
}

- (SUPlayerViewController *)playerVC {
    if(!_playerVC) {
        _playerVC = [SUPlayerViewController sharedInstance];
    }
    return _playerVC;
}

@end
