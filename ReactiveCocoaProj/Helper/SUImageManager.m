//
//  SUImageManager.m
//  SUYanXuan
//
//  Created by He on 2017/9/4.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUImageManager.h"

@implementation SUImageManager

+ (instancetype)defaultImageManager {
    static SUImageManager *imageManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageManager = [[SUImageManager alloc] init];
    });
    return imageManager;
}

- (void)setImageView:(UIImageView *)imageView withUrl:(NSString *)url {
    if([self objectForKey:url]) {
        imageView.image = [self objectForKey:url];
    }else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            [self setObject:image forKey:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        });

    }
}

- (void)fetchImageWithURL:(NSString *)url finish:(void(^)(UIImage *))finishHandler {
    if([self objectForKey:url]) {
        if(finishHandler) {
            finishHandler([self objectForKey:url]);
        }
    }else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            [self setObject:image forKey:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(finishHandler) {
                    finishHandler([self objectForKey:url]);
                }
            });
        });
        
    }
}

- (RACSignal *)imageWithUrl:(NSString *)url {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if([self objectForKey:url]) {
            [subscriber sendNext:[self objectForKey:url]];
        }else {
            @weakify(self);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSURL *URL = [NSURL URLWithString:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                @strongify(self);
                NSLog(@"SUImageManager error %@", error);
                if(error) {
                    return;
                }
                UIImage *image = [UIImage imageWithData:data];
                if(image) {
                    [self setObject:image forKey:url];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [subscriber sendNext:image];
                });
            }];
            [dataTask resume];

            
            });
            
        }
        return nil;
    }];
}

@end
