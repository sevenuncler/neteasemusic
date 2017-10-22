//
//  UIImage+Size.h
//  SUYanXuan
//
//  Created by He on 2017/9/8.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

- (UIImage *)imageWithSize:(CGSize)size;
- (UIImage *)imageWithCornerRadius:(CGFloat )radius;
- (UIImage *)imageWithCornerRadius:(CGFloat )radius targetSize:(CGSize)size;

- (UIImage *(^)(CGSize target, CGFloat value))round;
- (UIImage *(^)(CGSize target, CGFloat radium, CGFloat boardWidth))roundWithBoard;

@end
