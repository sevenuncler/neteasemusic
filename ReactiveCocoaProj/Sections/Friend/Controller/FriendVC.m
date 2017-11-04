//
//  FriendVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "FriendVC.h"
#import "StatusView.h"
#import "Macros.h"
@interface FriendVC ()

@end

@implementation FriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    StatusView *statusView = [[VideoStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    [self.view addSubview:statusView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
