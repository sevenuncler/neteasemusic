//
//  SUImageManager.h
//  SUYanXuan
//
//  Created by He on 2017/9/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface SUImageManager : NSCache

+ (instancetype)defaultImageManager;

- (void)setImageView:(UIImageView *)imageView withUrl:(NSString *)url;
- (void)fetchImageWithURL:(NSString *)url finish:(void(^)(UIImage *))finishHandler;

/*** RAC方法 ***/
- (RACSignal *)imageWithUrl:(NSString *)url;
@end
