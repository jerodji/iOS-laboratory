//
//  main.m
//  自定义对象深拷贝
//
//  Created by Jerod on 2021/3/28.
//

#import <Foundation/Foundation.h>
#import "Human.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        NSString * a = @"asdfsf";
        
        Human *girl = [Human new];
        girl.name = @"maryo";
        girl.age = 16;
        
        Human * man = [Human new];
        man.name = @"jk";
        man.age = 18;
        man.mate = girl;
        
        Human * hans = [man mutableCopy];
        NSLog(@"%@ %d %@, %@ %d", hans.name, hans.age, hans.mate,
              hans.mate.name, hans.mate.age);
        
        
    }
    return 0;
}
