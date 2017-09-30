//
//  SUHomeVC.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/30.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUHomeVC.h"
#import "SUItem.h"
#import "SUGoHorseLampView.h"
#import "SUGoHorseLampViewModel.h"
#import "SUTableViewCell.h"

@interface SUHomeVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) SUGoHorseLampView *goHorseLampView;
@property (nonatomic, strong) SUGoHorseLampViewModel *goHorseLampVM;

@end

@implementation SUHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.views.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseID = @"reuseID";
    SUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(cell == nil) {
        cell = [[SUTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.myContentView = [self.views objectAtIndex:indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Getter && Setter


@end
