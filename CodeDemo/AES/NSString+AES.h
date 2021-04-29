//
//  NSString+AES.h
//  MoveAudit
//
//  Created by 吉久东 on 2019/11/18.
//  Copyright © 2019 PING AN. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (AES)

// MARK: 256
/// AES256加密
 /// @param key 加密key
 /// @param iv 偏移量/nil
- (NSString*)AES256EncryptWithKey:(NSString*)key iv:(NSString*)iv;

/// AES256解密
/// @param key 加密key
/// @param iv 偏移量/nil
- (NSString*)AES256DecryptWithKey:(NSString*)key iv:(NSString*)iv;


// MARK: 128
/// AES128加密
/// @param key 加密key
/// @param iv 偏移量/nil
- (NSString*)AES128EncryptWithKey:(NSString*)key iv:(NSString*)iv;

/// AES128解密
/// @param key 加密key
/// @param iv 偏移量/nil
- (NSString*)AES128DecryptWithKey:(NSString*)key iv:(NSString*)iv;



// MARK: Data
/// base64 解码
- (NSData*)base64Decoding;

/// utf8 编码
- (NSData*)utf8Encoding;


- (Byte*)toBytes;



@end

