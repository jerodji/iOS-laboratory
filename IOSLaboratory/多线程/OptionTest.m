//
//  OptionTest.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/13.
//

#import "OptionTest.h"

@implementation OptionTest

+ (void)begin {
    OptionTest * t = [[OptionTest alloc] init];
    [t block];
}

// A B C 异步执行,可开启多条线程, 完成后执行Completion
- (void)block {
    NSBlockOperation * b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A , %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@"B , %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@"C , %@", [NSThread currentThread]);
    }];
    [b setCompletionBlock:^{
        NSLog(@"Completion , %@", [NSThread currentThread]);
    }];
    [b start];
}

@end
