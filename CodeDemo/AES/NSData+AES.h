//
//  NSData+AES.h
//  AES
//
//  Created by Jerod on 2020/8/28.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (AES)

/// AES256 加密
- (NSString *)AES256EncryptWithKey:(NSString *)key;

/// AES256 解密
- (NSString*)AES256DecryptWithKey:(NSString*)key;

/// AES128 加密
-(NSString *)AES128EncryptWithKey:(NSString *)key;

/// AES128 解密
- (NSString*)AES128DecryptWithKey:(NSString*)key;

@end


@interface NSString (En_Dc_coding)

/// base64 解码
- (NSData*)base64Decoding;

/// utf8 编码
- (NSData*)utf8Encoding;


- (Byte*)toBytes;

@end
