//
//  ThreadLock.m
//
//
//  Created by Jerod on 2021/5/26.
//

#import "ThreadLock.h"
#import <QuartzCore/QuartzCore.h>
#import <os/lock.h>
#import <libkern/OSAtomic.h>
#import <pthread/pthread.h>


static NSInteger TAG = 0;

@interface ThreadLock ()
@property (nonatomic, strong) NSCondition *condition;
//@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, assign) int count;
@end

@implementation ThreadLock

+ (void)begin {
    ThreadLock * t = [[ThreadLock alloc] init];
    [t sale];
}

- (void)sale
{
    TAG++;
    
    NSOperationQueue *q1 = [NSOperationQueue new];
    NSOperationQueue *q2 = [NSOperationQueue new];
    NSOperationQueue *q3 = [NSOperationQueue new];
    NSOperationQueue *q4 = [NSOperationQueue new];

    NSInvocationOperation * op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation) object:nil];
    NSInvocationOperation * op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation) object:nil];
    NSInvocationOperation * op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation) object:nil];
    NSInvocationOperation * op4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation) object:nil];
    [q1 addOperation:op1];
    [q2 addOperation:op2];
    [q3 addOperation:op3];
    [q4 addOperation:op4];
    
//    [self operation];
}

- (void)operation {
    NSTimeInterval begin, end;
    
    NSInteger r = TAG % 10;
    switch (r) {
        // OSSpinLock
        case 1: {
            OSSpinLock lock = OS_SPINLOCK_INIT;
            begin = CACurrentMediaTime();
            OSSpinLockLock(&lock);
            [self saleTick];
            OSSpinLockUnlock(&lock);
            end = CACurrentMediaTime();
            printf("OSSpinLock  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // os_unfair_lock
        case 2: {
            os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
            begin = CACurrentMediaTime();
            os_unfair_lock_lock(&lock);
            [self saleTick];
            os_unfair_lock_unlock(&lock);
            end = CACurrentMediaTime();
            printf("os_unfair_lock  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // dispatch_semaphore_t
        case 3: {
            dispatch_semaphore_t dsema = dispatch_semaphore_create(1);
            begin = CACurrentMediaTime();
            dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
            [self saleTick];
            dispatch_semaphore_signal(dsema);
            end = CACurrentMediaTime();
            printf("dispatch_semaphore_t  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // NSLock
        case 4: {
            NSLock *lock = [NSLock new];
            begin = CACurrentMediaTime();
            [lock lock];
            [self saleTick];
            [lock unlock];
            end = CACurrentMediaTime();
            printf("NSLock  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // NSCondition
        case 5: {
            NSCondition * lock = [NSCondition new];
            begin = CACurrentMediaTime();
            [lock lock];
            [self saleTick];
            [lock unlock];
            end = CACurrentMediaTime();
            printf("NSCondition  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // pthread_mutex 互斥锁
        case 6: {
            pthread_mutex_t lock;
            pthread_mutex_init(&lock, NULL);
            begin = CACurrentMediaTime();
            pthread_mutex_lock(&lock);
            [self saleTick];
            pthread_mutex_unlock(&lock);
            end = CACurrentMediaTime();
            printf("pthread_mutex_t  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // NSConditionLock
        case 7: {
            NSConditionLock * lock = [NSConditionLock new];
            begin = CACurrentMediaTime();
            [lock lock];
            [self saleTick];
            [lock unlock];
            end = CACurrentMediaTime();
            printf("NSConditionLock  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // NSRecursiveLock, 递归锁
        case 8: {
            NSRecursiveLock * lock = [NSRecursiveLock new];
            begin = CACurrentMediaTime();
            [lock lock];
            [self saleTick];
            [lock unlock];
            end = CACurrentMediaTime();
            printf("NSRecursiveLock  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        // @synchronized
        case 9: {
            NSObject *lock = [NSObject new];
            begin = CACurrentMediaTime();
            @synchronized (lock) {
                [self saleTick];
            }
            end = CACurrentMediaTime();
            printf("@synchronized  %.2f μs\n", (end - begin)*1000*1000);
        } break;
            
        default:
            break;
    }
    
    /*
     
     OSSpinLock  85.75 μs
     OSSpinLock  32.58 μs
     OSSpinLock  32.63 μs
     OSSpinLock  32.50 μs

     os_unfair_lock  103.79 μs
     os_unfair_lock  32.54 μs
     os_unfair_lock  32.37 μs
     os_unfair_lock  32.37 μs

     dispatch_semaphore_t  63.67 μs
     dispatch_semaphore_t  48.58 μs
     dispatch_semaphore_t  48.46 μs
     dispatch_semaphore_t  48.33 μs

     NSLock  91.00 μs
     NSLock  90.29 μs
     NSLock  89.88 μs
     NSLock  89.88 μs

     NSCondition  89.54 μs
     NSCondition  50.29 μs
     NSCondition  48.71 μs
     NSCondition  48.71 μs

     pthread_mutex_t  86.29 μs
     pthread_mutex_t  53.33 μs
     pthread_mutex_t  43.33 μs
     pthread_mutex_t  43.29 μs

     NSConditionLock  37.42 μs
     NSConditionLock  177.00 μs
     NSConditionLock  31.88 μs
     NSConditionLock  32.29 μs

     NSRecursiveLock  94.08 μs
     NSRecursiveLock  92.71 μs
     NSRecursiveLock  90.50 μs
     NSRecursiveLock  324.92 μs

     @synchronized  129.62 μs
     @synchronized  91.46 μs
     @synchronized  91.17 μs
     @synchronized  440.25 μs


     */
 


    
    
    
}

- (void)saleTick {
    int num = 5000;
    while (num > 0) {
        num--;
    }
//    while (self.total > 0) {
//        self.total--;
//        //NSLog(@"current %d", self.total);
//    }
}

// MARK: -

+ (void)condition {
    NSCondition *condition = [NSCondition new];
    NSMutableArray * arr = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        
        while (arr.count == 0) {
            [condition wait];
        }
        [arr removeObjectAtIndex:0];
        
        [condition unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        
        [arr addObject:@"mock"];
        [condition signal];
        
        [condition unlock];
    });
    
}



- (void)testCondition {
    self.count = 0;
    self.condition = [[NSCondition alloc] init];
    
    NSThread * t1 = [[NSThread alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [t1 setName:@"AA"];
    
    NSThread * t2 = [[NSThread alloc] initWithTarget:self selector:@selector(task2) object:nil];
    [t2 setName:@"BB"];
    
    NSThread * t3 = [[NSThread alloc] initWithTarget:self selector:@selector(task3) object:nil];
    [t3 setName:@"CC"];
    
    [t1 start];
    [t2 start];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [t3 start];
    });
}

- (void)task1 {
    [self.condition lock];
    
    while (self.count == 0) {
        NSLog(@"task1 begin wait, %@", [NSThread currentThread]);
        [self.condition wait];
    }
    NSLog(@"task1 will sleep");
    [NSThread sleepForTimeInterval:1];
    self.count--;
    NSLog(@"task1 end: %d", self.count);
    
    [self.condition unlock];
}

- (void)task2 {
    [self.condition lock];
    
    while (self.count == 0) {
        NSLog(@"task2 begin wait, %@", [NSThread currentThread]);
        [self.condition wait];
    }
    self.count--;
    NSLog(@"task2 end: %d", self.count);
    
    [self.condition unlock];
}

- (void)task3 {
    [self.condition lock];

    self.count++;
    
    NSLog(@"task3 signal 1, %@", [NSThread currentThread]);
    [self.condition signal];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"task3 signal 2, %@", [NSThread currentThread]);
        [self.condition signal];
    });
    
//    [self.condition broadcast];

    [self.condition unlock];
}

/*
 使用 if
 12:08:35 task1 begin wait, <NSThread: 0x28050f800>{number = 8, name = AA}
 12:08:35 task2 begin wait, <NSThread: 0x28050f840>{number = 9, name = BB}
 12:08:38 task3 signal 1, <NSThread: 0x28050f880>{number = 10, name = CC}
 12:08:38 task1 end: 0
 12:08:40 task3 signal 2, <NSThread: 0x280550f40>{number = 1, name = main}
 12:08:40 task2 end: -1
 
 使用 while
 12:09:22 task1 begin wait, <NSThread: 0x283d15540>{number = 6, name = AA}
 12:09:22 task2 begin wait, <NSThread: 0x283d154c0>{number = 7, name = BB}
 12:09:25 task3 signal 1, <NSThread: 0x283d15480>{number = 8, name = CC}
 12:09:25 task1 end: 0
 12:09:27 task3 signal 2, <NSThread: 0x283d70f40>{number = 1, name = main}
 12:09:27 task2 begin wait, <NSThread: 0x283d154c0>{number = 7, name = BB}
 
 [self.condition broadcast];
 2021-05-27 13:51:07.682951+0800 IOSLaboratory[1036:562928] task2 begin wait, <NSThread: 0x2818c8980>{number = 9, name = BB}
 2021-05-27 13:51:07.683187+0800 IOSLaboratory[1036:562927] task1 begin wait, <NSThread: 0x2818c89c0>{number = 8, name = AA}
 2021-05-27 13:51:10.945754+0800 IOSLaboratory[1036:562928] task2 end: 0
 2021-05-27 13:51:10.946171+0800 IOSLaboratory[1036:562927] task1 begin wait, <NSThread: 0x2818c89c0>{number = 8, name = AA}
 */


@end
