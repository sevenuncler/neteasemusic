//
//  NSString+NSString_MD5.m
//  ReactiveCocoaProj
//
//  Created by He on 2017/11/18.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Encrypt)

+ (NSData *)aesWithData:(NSData *)data withKey:(NSString *)key {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t numBytesDecrypted = 0;
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void   *buffer    = malloc(bufferSize);
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCBlockSizeAES128, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)aes:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSString aesWithData:data withKey:key];
}

- (id)md5 {
    const char *src = [self UTF8String];
    unsigned char result[16]    = {0};
    CC_MD5(src, (CC_LONG)strlen(src), result);
    NSString *md5 = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        result[0], result[1], result[2], result[3],
                        result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11],
                        result[12], result[13], result[14], result[15]
                        ];
    return md5;
}

@end
