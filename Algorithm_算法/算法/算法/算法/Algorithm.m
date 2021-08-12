//
//  Algorithm.m
//  算法
//
//  Created by Jerod on 2020/6/17.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

//一、字符串反转
- (void)charReverse1
{
    NSString * string = @"hello,world";
    
    NSLog(@"%@",string);
    
    NSMutableString * reverString = [NSMutableString stringWithString:string];
    
    for (NSInteger i = 0; i < (string.length + 1)/2; i++) {
        
        [reverString replaceCharactersInRange:NSMakeRange(i, 1)
                                   withString:[string substringWithRange:NSMakeRange(string.length - i - 1, 1)]];
        
        [reverString replaceCharactersInRange:NSMakeRange(string.length - i - 1, 1)
                                   withString:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"reverString:%@",reverString);
}

//一、字符串反转
- (void)charReverse2 {
    NSString * string = @"hello,world";
    
    NSLog(@"%@",string);
    
    //C
    char ch[100];
    
    memcpy(ch, [string cStringUsingEncoding:NSUTF8StringEncoding], [string length]);

   //设置两个指针，一个指向字符串开头，一个指向字符串末尾
    char * begin = ch;
    
    char * end = ch + strlen(ch) - 1;
   
    //遍历字符数组，逐步交换两个指针所指向的内容，同时移动指针到对应的下个位置，直至begin>=end 
    while (begin < end) {
        
        char temp = *begin;
        
        *(begin++) = *end;
        
        *(end--) = temp;
    }
    
    NSLog(@"reverseChar[]:%s",ch);
}

@end
