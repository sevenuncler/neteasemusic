//
//  ViewController.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/9/29.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "ViewController.h"
#import "SUImageManager.h"
#import "SUGoHorseLampView.h"
#import "SUGoHorseLampViewModel.h"
#import "SUGoHorseLampCell.h"
#import "Macros.h"
#import "SUHomeVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) SUGoHorseLampView         *goHorseLampView;
@property (nonatomic, strong) SUGoHorseLampViewModel    *goHorseLampVM;
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) UIView *myView;

@end

@implementation ViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView transitionWithView:self.view duration:2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.myView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.myView];
    self.view.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:self.goHorseLampView];
    self.goHorseLampVM.items = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2876169151,2235209253&fm=27&gp=0.jpg", @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3257648166,2653121674&fm=27&gp=0.jpg", @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3372103345,2665413911&fm=27&gp=0.jpg", @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3396335410,3051374929&fm=27&gp=0.jpg"].mutableCopy;
    self.obj = [self newObj];
    @weakify(self);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        @strongify(self);
//        NSLog(@"2 >> %s", __func__);
//        //            [self.goHorseLampVM startTimer];
//        [self presentViewController:[SUHomeVC new] animated:YES completion:nil];
//        
//    });
   [self.goHorseLampVM.timerSignal subscribeNext:^(id x) {
       @strongify(self);
       [self.goHorseLampView scrollToItemAtIndexPath:x atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
   }];
    
    
    [[self.goHorseLampVM rac_signalForSelector:@selector(scrollViewWillBeginDragging:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(id x) {
        NSLog(@"1 >> %s", __func__);
        @strongify(self);
        [self.goHorseLampVM pauseTimer];
    }];
    
    [[self.goHorseLampVM rac_signalForSelector:@selector(scrollViewDidEndDecelerating:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(id x)  {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            NSLog(@"2 >> %s", __func__);
//            [self.goHorseLampVM startTimer];
            [self presentViewController:[SUHomeVC new] animated:YES completion:nil];

        });
    }];
}

- (void)dealloc {
    NSLog(@">>> %s <<<", __func__);
}

#pragma mark - Bind

- (void)goHorseBind {
    
}

- (id)newObj {
    NSObject *obj = [NSObject new];
    return obj;
}

#pragma mark - Getter & Setter

- (SUGoHorseLampView *)goHorseLampView {
    if(!_goHorseLampVM) {
        _goHorseLampView = [[SUGoHorseLampView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.618f)];
        static NSString * const reuseID = @"goHorseCell";
        [_goHorseLampView registerClass:[SUGoHorseLampCell class] forCellWithReuseIdentifier:reuseID];
        _goHorseLampView.dataSource = self.goHorseLampVM;
        _goHorseLampView.delegate   = self.goHorseLampVM;
    }
    return _goHorseLampView;
}

- (SUGoHorseLampViewModel *)goHorseLampVM {
    if(!_goHorseLampVM) {
        _goHorseLampVM = [SUGoHorseLampViewModel new];
    }
    return _goHorseLampVM;
}


@end
