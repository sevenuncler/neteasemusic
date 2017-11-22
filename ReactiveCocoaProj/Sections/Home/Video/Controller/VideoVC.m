//
//  VideoVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/17.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "VideoVC.h"
#import "Macros.h"
#import "VideoViewCell1.h"
@interface VideoVC ()

@end
static NSString * const reuseID = @"reuseVideoViewCell1";
@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[VideoViewCell1 class] forCellReuseIdentifier:reuseID
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH * 0.618;
}

@end
