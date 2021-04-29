//
//  main.m
//  AES
//
//  Created by Jerod on 2020/8/27.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+AES.h"

//#import "NSData+AES.h"

#import "AESCipher/AESCipher.h"

int main(int argc, const char * argv[]) {
    
//    /**
//     http://skjdfhakshdfkahsfk哈哈
//     rtHp6RfmvOnfG9bsVFRs9Kx0UHP4yd23a/5p3cY6Akg=
//     )Zc*jl8TuP^twk(J
//     上面是加密后的，下面是key
//     */
//
//    NSString * TEXT = @"http://skjdfhakshdfkahsfk哈哈";
//    NSString * KEY = @")Zc*jl8TuP^twk(J";
//    NSString * MIW = @"rtHp6RfmvOnfG9bsVFRs9Kx0UHP4yd23a/5p3cY6Akg=";
//
//    // 加密
//    NSString * mimi = [[TEXT utf8Encoding] AES256EncryptWithKey:KEY];
//    NSLog(@"mimi === %@", mimi); //rtHp6RfmvOnfG9bsVFRs9Kx0UHP4yd23a/5p3cY6Akg=
//
//    //解密
//    NSString * wen = [[MIW base64Decoding] AES256DecryptWithKey:KEY];
//    NSLog(@"wen --- %@", wen); //http://skjdfhakshdfkahsfk哈哈
    
    
    
    NSString * TEXT = @"123456";
    NSString * KEY = @"ZdKtbEFmkS2YOVkk";
    NSString * IV = @"A-16-Byte-String";
    //tjQK93D2x63Y+8MJZ+N/XA==
    
    NSString * m1 = [TEXT AES128EncryptWithKey:KEY iv:IV];
    NSLog(@"11加密结果:%@", m1);
    NSString * t = [m1 AES128DecryptWithKey:KEY iv:IV];
    NSLog(@"11解密结果:%@", t);
    
    //AESCipher 偏移量在 AESCipher.m 中被写死了
    NSString* m2 = aesEncryptString(TEXT, KEY);
    NSLog(@"22加密结果:%@",m2);
    NSString* t2 = aesDecryptString(m2, KEY);
    NSLog(@"22解密结果:%@", t2);
    
/*
ZdKtbEFmkS2YOVkk
A-16-Byte-String
rrEkd+KoSUO/gPdSr0etpw==
*/

    
    return 0;
}
