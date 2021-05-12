//
//  DispatchTest.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/12.
//

#import "DispatchTest.h"

@implementation DispatchTest

+ (void)begin {
    [self m];
}

+ (void)m {
    dispatch_queue_t que = dispatch_queue_create("cx", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(que, ^{
        NSLog(@"task 1 - %@",[NSThread currentThread]);
        dispatch_async(que, ^{
            NSLog(@"task 2 - %@",[NSThread currentThread]);
        });
        dispatch_async(que, ^{
            NSLog(@"task 3 - %@",[NSThread currentThread]);
        });
        dispatch_async(que, ^{
            NSLog(@"task 4 - %@",[NSThread currentThread]);
        });
    });
    dispatch_async(que, ^{
        NSLog(@"task 5 - %@",[NSThread currentThread]);
    });
    dispatch_async(que, ^{
        NSLog(@"task 6 - %@",[NSThread currentThread]);
    });
    dispatch_async(que, ^{
        NSLog(@"task 7 - %@",[NSThread currentThread]);
    });
}

+ (void)operation {
    //    NSBlockOperation * bo = [NSBlockOperation blockOperationWithBlock:^{
    //        for (int i=0; i< 3; i++) {NSLog(@"1 - %@",[NSThread currentThread]);}
    //    }];
    //    [bo addExecutionBlock:^{
    //        for (int i=0; i< 3; i++) {NSLog(@"2 - %@",[NSThread currentThread]);}
    //    }];
    ////    [bo start]; // 异步
    //
    //    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    //    queue.maxConcurrentOperationCount = 1;
    //    [queue addOperation:bo];
    //    [queue addOperationWithBlock:^{
    //        for (int i=0; i< 3; i++) {NSLog(@"3 - %@",[NSThread currentThread]);}
    //    }];
    //
      
}


/*
NSLog(@"task 1 - %@",[NSThread currentThread]);
for (int i=0; i< 3; i++) {NSLog(@"1 - %@",[NSThread currentThread]);}
for (int i=0; i< 3; i++) {NSLog(@"2 - %@",[NSThread currentThread]);}
for (int i=0; i< 3; i++) {NSLog(@"3 - %@",[NSThread currentThread]);}
*/


@end
