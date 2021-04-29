//
//  main.m
//  CodeTest
//
//  Created by Jerod on 2021/4/8.
//

#import <Foundation/Foundation.h>

void asyncSerial() {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"asyncSerial---end");
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        NSLog(@"Hello, World!, %@", [NSThread currentThread]);
//
//        dispatch_queue_t q = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
////        dispatch_queue_t q = dispatch_get_main_queue();
//        dispatch_async(q, ^{
////            [NSThread sleepForTimeInterval:2];
//            NSLog(@"1---%@",[NSThread currentThread]);
//        });
//        dispatch_async(q, ^{
////            [NSThread sleepForTimeInterval:2];
//            NSLog(@"2---%@",[NSThread currentThread]);
//        });
//        dispatch_async(q, ^{
////            [NSThread sleepForTimeInterval:2];
//            NSLog(@"3---%@",[NSThread currentThread]);
//        });
//
//        NSLog(@"end --- %@", [NSThread currentThread]);
        
        asyncSerial();
    }
    return 0;
}


