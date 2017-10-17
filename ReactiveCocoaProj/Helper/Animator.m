//
//  Animator.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/10/14.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "Animator.h"
#import <UIKit/UIKit.h>

@implementation Animator

+ (instancetype)sharedAnimator {
    static Animator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Animator new];
    });
    return instance;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
//    toView.alpha = 0;
//    toView.frame = CGRectZero;
    [transitionContext.containerView addSubview:toView];
    [UIView transitionWithView:toView duration:[self transitionDuration:transitionContext] options:UIViewAnimationOptionTransitionFlipFromRight animations:^{

    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，    如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    //因为对截图做动画，vc1就可以隐藏了
    fromVC.view.hidden = YES;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];

    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height , containerView.frame.size.width, 400);
    //开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        //首先我们让vc2向上移动
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        //然后让截图视图缩小一点即可
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
        fromVC.view.transform = CGAffineTransformIdentity;

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
    
   
//    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        toView.alpha = 1;
//        toView.frame = fromView.frame;
//    } completion:^(BOOL finished) {
//
//    }];
//    [UIView transitionFromView:fromView toView:toView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //还是使用截图大法来完成动画，不然还是会有奇妙的bug;
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    //将将要动画的视图加入containerView
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
//    fromVC.view.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];
    //设置AnchorPoint，并增加3D透视效果
//    [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transfrom3d;
    //增加阴影
    CAGradientLayer *fromGradient = [CAGradientLayer layer];
    fromGradient.frame = fromVC.view.bounds;
    fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
                            (id)[UIColor blackColor].CGColor];
    fromGradient.startPoint = CGPointMake(0.0, 0.5);
    fromGradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    fromShadow.backgroundColor = [UIColor clearColor];
    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
    fromShadow.alpha = 0.0;
    [tempView addSubview:fromShadow];
    CAGradientLayer *toGradient = [CAGradientLayer layer];
    toGradient.frame = fromVC.view.bounds;
    toGradient.colors = @[(id)[UIColor blackColor].CGColor,
                          (id)[UIColor blackColor].CGColor];
    toGradient.startPoint = CGPointMake(0.0, 0.5);
    toGradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    toShadow.backgroundColor = [UIColor clearColor];
    [toShadow.layer insertSublayer:toGradient atIndex:1];
    toShadow.alpha = 1.0;
    [toVC.view addSubview:toShadow];
    //动画吧
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //翻转截图视图
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        //给阴影效果动画
        fromShadow.alpha = 1.0;
        toShadow.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //失败后记得移除截图，下次push又会创建
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
}

//Present动画逻辑
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    //拿到控制器获取button的frame来设置动画的开始结束的路径
//    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    XWCircleSpreadController *temp = fromVC.viewControllers.lastObject;
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toVC.view];
//    //画两个圆路径
//    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
//    //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
//    CGFloat x = MAX(temp.buttonFrame.origin.x, containerView.frame.size.width - temp.buttonFrame.origin.x);
//    CGFloat y = MAX(temp.buttonFrame.origin.y, containerView.frame.size.height - temp.buttonFrame.origin.y);
//    //勾股定理计算半径
//    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
//    //以按钮中心为圆心，按钮中心到屏幕边缘的最大距离为半径，得到转场后的path
//    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    //创建CAShapeLayer进行遮盖
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    //设置layer的path保证动画后layer不会回弹
//    maskLayer.path = endCycle.CGPath;
//    //将maskLayer作为toVC.View的遮盖
//    toVC.view.layer.mask = maskLayer;
//    //创建路径动画
//    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    maskLayerAnimation.delegate = self;
//    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
//    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
//    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
//    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
//    maskLayerAnimation.delegate = self;
//    //设置淡入淡出
//    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
//    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

//Dismiss动画逻辑
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    XWCircleSpreadController *temp = toVC.viewControllers.lastObject;
//    UIView *containerView = [transitionContext containerView];
//    //画两个圆路径
//    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
//    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
//    //创建CAShapeLayer进行遮盖
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.fillColor = [UIColor greenColor].CGColor;
//    maskLayer.path = endCycle.CGPath;
//    fromVC.view.layer.mask = maskLayer;
//    //创建路径动画
//    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    maskLayerAnimation.delegate = self;
//    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
//    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
//    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
//    maskLayerAnimation.delegate = self;
//    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
//    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

@end
