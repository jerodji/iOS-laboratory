//
//  main.m
//  block
//
//  Created by Jerod on 2021/8/30.
//  Copyright © 2021 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 局部变量是值捕获
        NSMutableArray * arr = [NSMutableArray arrayWithArray:@[@1,@2]];
        
        void (^testBlock)() = ^ {
            NSLog(@"a -- %p, %@",&arr, arr);//0x100705850, 123
            [arr addObject:@4];
        };
        
        [arr addObject:@3];
        NSLog(@"c -- %p, %@",&arr, arr);// 0x7ffeefbff450, 123
        
        arr = nil;
        NSLog(@"d -- %p, %@",&arr, arr);// 0x7ffeefbff450, null
        
        testBlock();
        NSLog(@"e -- %p, %@",&arr, arr);// 0x7ffeefbff450, null
    }
    return 0;
}
