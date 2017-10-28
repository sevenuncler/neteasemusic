//
//  SUPlayerViewController.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/25.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUPlayerViewController.h"
#import "PlayerView.h"
#import "UIView+Layout.h"
#import "Macros.h"

@interface SUPlayerViewController ()

@end

@implementation SUPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    PlayerView *view = [[PlayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];

    PlayerLongPlaying *plp = [[PlayerLongPlaying alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    plp.centerX = view.centerX;
    plp.centerY = view.centerY*0.89;
    [view addSubview:plp];
    [plp start];
    
    PlayerMenu *menu = [[PlayerMenu alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, 120)];
    menu.botton = view.botton;
    [view addSubview:menu];
    
    PlayerProgress *progress = [[PlayerProgress alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    progress.botton = menu.top;
    [view addSubview:progress];
    
    PlayerAssistant *assistant = [[PlayerAssistant alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    assistant.botton = progress.top;
    [view addSubview:assistant];
    
    CGFloat width = 111;
    PlayerPointer *pointer = [[PlayerPointer alloc] initWithFrame:CGRectMake(0, 0, width, width*366/222)];
    pointer.centerX = SCREEN_WIDTH / 2 + 20;
    pointer.top = 20;
    [view addSubview:pointer];
    [pointer stop];
    [pointer play];
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
