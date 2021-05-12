//
//  main.m
//  内存管理
//
//  Created by Jerod on 2021/5/8.
//  Copyright © 2021 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//    }
    
    
    NSObject * a = [NSObject alloc];
    NSLog(@"1 a %lu", (unsigned long)[a retainCount]);
    [a release];
    NSLog(@"2 a %lu", (unsigned long)[a retainCount]);
    
    NSObject * b = [[NSObject alloc] init];
    NSLog(@"3 b %lu", (unsigned long)[b retainCount]);
    
    
    
    return 0;
}
