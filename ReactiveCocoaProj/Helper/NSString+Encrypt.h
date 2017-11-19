//
//  NSString+NSString_MD5.h
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

+ (NSData *)aesWithData:(NSData *)data withKey:(NSString *)key;

- (id)md5;
- (NSData *)aes:(NSString *)key;
@end
