//
//  SUPlayerViewController.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUPlayerViewController.h"
#import "PlayerView.h"

@interface SUPlayerViewController ()

@end

@implementation SUPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PlayerLongPlaying *plp = [[PlayerLongPlaying alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:plp];
    [plp start];
    // Do any additional setup after loading the view.
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
