//
//  UIImage+Size.m
//  SUYanXuan
//
//  Created by He on 2017/9/8.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

- (UIImage *)imageWithSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *(^)(CGSize target, CGFloat value))round {
    return ^UIImage *(CGSize target, CGFloat radius){
        UIGraphicsBeginImageContextWithOptions(target, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){0,0,target} cornerRadius:radius];
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        [self drawInRect:(CGRect){0,0,target}];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    };
}

- (UIImage *(^)(CGSize target, CGFloat radius, CGFloat boardWidth))roundWithBoard {
    return ^UIImage *(CGSize target, CGFloat radius, CGFloat boardWidth) {
        UIGraphicsBeginImageContextWithOptions(target, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){0,0,target} cornerRadius:radius];
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        [self drawInRect:(CGRect){0,0,target}];
        
        CGContextSetRGBStrokeColor(context,1,0,0,1.0);//画笔线的颜色
        CGContextSetLineWidth(context, boardWidth);//线的宽度
        //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
        // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
        CGContextAddArc(context, target.width/2, target.height/2, target.width/2, 0, 2*M_PI, 0); //添加一个圆
        CGContextDrawPath(context, kCGPathStroke); //绘制路径
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    };
}

-(UIImage *)imageWithCornerRadius:(CGFloat)radius targetSize:(CGSize)size {
    CGRect rect = (CGRect){0.f,0.f,size};
    
    // void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
    //size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    //    opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    //    scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    //根据矩形画带圆角的曲线
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [self drawInRect:rect];
    
    //图片缩放，是非线程安全的
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

-(UIImage *)imageWithCornerRadius:(CGFloat )radius
{
    return [self imageWithCornerRadius:radius targetSize:self.size];
}

@end
