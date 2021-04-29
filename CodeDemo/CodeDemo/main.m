//
//  main.m
//  CodeDemo
//
//  Created by Jerod on 2020/8/11.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray * arr = @[@"a", @"b", @"c"];
        NSDictionary *data = (NSDictionary*)arr;
        NSLog(@"data == %@", data);
        
    }
    return 0;
}
