//
//  NSString+AES.m
//  MoveAudit
//
//  Created by 吉久东 on 2019/11/18.
//  Copyright © 2019 PING AN. All rights reserved.
//

#import "NSString+AES.h"
#import <CommonCrypto/CommonCryptor.h>


@implementation NSString (AES)

- (NSData*)_cipherWithContent:(NSData*)contentData key:(NSData*)keyData iv:(NSData*)ivData operation:(CCOperation)operation keySize:(size_t)keySize
{
    NSUInteger dataLength = contentData.length;
    
    void const *ivBytes = ivData ? ivData.bytes : NULL;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;
    
    size_t bufferSize = dataLength + keySize;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyBytes,
                                          keySize,
                                          ivBytes,
                                          contentBytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


// MARK: AES256加密
/**
 AES加密
 self: 明文JSON串
 @param key  加密key
 @param iv   偏移量
 @return     密文
 */
- (NSString*)AES256EncryptWithKey:(NSString*)key iv:(NSString*)iv
{
    NSString* content = self;
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = iv ? [iv dataUsingEncoding:NSUTF8StringEncoding] : nil;
    NSData *encrptData = [self _cipherWithContent:contentData key:keyData iv:ivData operation:kCCEncrypt keySize:kCCKeySizeAES256];
    return [encrptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

// MARK: AES256解密
/**
 解密
 self: 密文串
 @param key 加密key
 @param iv  偏移量
 @return    明文
 */
- (NSString*)AES256DecryptWithKey:(NSString*)key iv:(NSString*)iv
{
    NSString *content = self;
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = iv ? [iv dataUsingEncoding:NSUTF8StringEncoding] : nil;
    NSData *decryptedData = [self _cipherWithContent:contentData key:keyData iv:ivData operation:kCCDecrypt keySize:kCCKeySizeAES256];
    if (decryptedData) {
        return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    } else {
        // 解密失败使用原内容
        return content;
    }
}

// MARK: AES128加密
- (NSString*)AES128EncryptWithKey:(NSString*)key iv:(NSString*)iv
{
    NSString* content = self;
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = iv ? [iv dataUsingEncoding:NSUTF8StringEncoding] : nil;
    NSData *encrptData = [self _cipherWithContent:contentData key:keyData iv:ivData operation:kCCEncrypt keySize:kCCKeySizeAES128];
    return [encrptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

// MARK: AES128解密
- (NSString*)AES128DecryptWithKey:(NSString*)key iv:(NSString*)iv
{
    NSString *content = self;
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = iv ? [iv dataUsingEncoding:NSUTF8StringEncoding] : nil;
    NSData *decryptedData = [self _cipherWithContent:contentData key:keyData iv:ivData operation:kCCDecrypt keySize:kCCKeySizeAES128];
    if (decryptedData) {
        return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    } else {
        // 解密失败使用原内容
        return content;
    }
}


// MARK: base64 Data
/// base64解码
- (NSData*)base64Decoding
{
    NSString *text = self;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

// MARK: UTF8 Data
/// utf8编码
- (NSData*)utf8Encoding
{
    NSString *text = self;
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

// MARK: bytes
- (Byte*)toBytes
{
    NSString *str = self;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(NSUTF8StringEncoding);
    NSData *data = [str dataUsingEncoding:enc];
    Byte *byte = (Byte *)[data bytes];
    for (int i=0 ; i<[data length]; i++) {
        NSLog(@"%s, byte = %d", __func__, byte[i]);
    }
    NSLog(@"%s, %s",__func__, byte);
    return byte;
}


@end
