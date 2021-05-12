//
//  DispatchTest.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/12.
//

#import "DispatchTest.h"
#import "AFNetworking.h"

//static const void * GLOBAL_QUEUE = "global_queue";

@implementation DispatchTest

+ (void)begin {
//    dispatch_queue_set_specific(dispatch_get_global_queue(0, 0), GLOBAL_QUEUE, &GLOBAL_QUEUE, nil);
    [self group_enter_leave_request];
}

// wati只适用于同步任务
+ (void)group_wait {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, globalQueue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), globalQueue, ^{
            NSLog(@"task 1 - %@",[NSThread currentThread]);
            
        });
    });
    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"task 2 - %@",[NSThread currentThread]);
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"task 3 - %@",[NSThread currentThread]);
    
//    2
//    3
//    1
}

+ (void)group_enter_leave_request {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        // request 1
        dispatch_group_enter(group);
        NSURLRequest * req1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.taobao.com/"]];
        NSURLSessionDataTask * task1 = [[NSURLSession sharedSession] dataTaskWithRequest:req1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"task 1 - %@",[NSThread currentThread]);
            dispatch_group_leave(group);
        }];
        [task1 resume];
        
        // request 2
        dispatch_group_enter(group);
        NSLog(@">>>>> 123213");
        NSURLRequest * req2 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:8];
        NSURLSessionDataTask * task2 = [[NSURLSession sharedSession] dataTaskWithRequest:req2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"task 2 - %@",[NSThread currentThread]);
            dispatch_group_leave(group);
        }];
        [task2 resume];
        
        // last
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"task 3 - %@",[NSThread currentThread]);
        });
    });
    
}

+ (void)groupNotify {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    NSLog(@"task group begin");
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"task 1 - %@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"task 2 - %@",[NSThread currentThread]);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"task 4 - %@",[NSThread currentThread]);
    });
//+[DispatchTest groupNotify]_block_invoke_2(27): task 2 - <NSThread: 0x6000025a8880>{number = 6, name = (null)}
//+[DispatchTest groupNotify]_block_invoke(24): task 1 - <NSThread: 0x6000025bd1c0>{number = 5, name = (null)}
//+[DispatchTest groupNotify]_block_invoke_3(30): task 4 - <NSThread: 0x6000025fccc0>{number = 1, name = main}
}

+ (void)apply {
    NSArray * arr = @[@1,@2,@3,@4,@5,@6];
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply begin");
    // 多个线程异步执行,乱序调用
    dispatch_apply(arr.count, globalQueue, ^(size_t index) {
        NSLog(@"arr index:%lu, %@, thread:%@", index, arr[index], [NSThread currentThread]);
    });
    NSLog(@"apply end");
    
// +[DispatchTest apply](19): apply begin
// +[DispatchTest apply]_block_invoke(22): arr index:0, 1, thread:<NSThread: 0x6000039800c0>{number = 1, name = main}
// +[DispatchTest apply]_block_invoke(22): arr index:2, 3, thread:<NSThread: 0x6000039800c0>{number = 1, name = main}
// +[DispatchTest apply]_block_invoke(22): arr index:3, 4, thread:<NSThread: 0x6000039800c0>{number = 1, name = main}
// +[DispatchTest apply]_block_invoke(22): arr index:1, 2, thread:<NSThread: 0x6000039c9580>{number = 3, name = (null)}
// +[DispatchTest apply]_block_invoke(22): arr index:4, 5, thread:<NSThread: 0x6000039800c0>{number = 1, name = main}
// +[DispatchTest apply]_block_invoke(22): arr index:5, 6, thread:<NSThread: 0x6000039c9580>{number = 3, name = (null)}
// +[DispatchTest apply](24): apply end
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
