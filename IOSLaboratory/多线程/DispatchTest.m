
#import "DispatchTest.h"
#import "AFNetworking.h"

//static const void * GLOBAL_QUEUE = "global_queue";

@interface DispatchTest ()
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation DispatchTest

+ (void)begin {
//    dispatch_queue_set_specific(dispatch_get_global_queue(0, 0), GLOBAL_QUEUE, &GLOBAL_QUEUE, nil);
    
    DispatchTest *s = [[self alloc] init];
    s.total = 50;
    [s saleTicket_safe_three];
}

// MARK: - 线程安全 多读单写, 售卖火车票

- (void)saleTicket_nosafe {
    dispatch_queue_t que1 = dispatch_queue_create("beijing", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t que2 = dispatch_queue_create("shanghai", DISPATCH_QUEUE_SERIAL);
    dispatch_async(que1, ^{
        while (self.total >= 0) {
            NSLog(@"1 剩余: %ld", (long)self.total);
            self.total--;
        }
    });
    dispatch_async(que2, ^{
        while (self.total >= 0) {
            NSLog(@"2 剩余: %ld", (long)self.total);
            self.total--;
        }
    });
    
    // 线程不安全, 结果错乱
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 7
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 6
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 5
//    -[DispatchTest saleTicket_nosafe]_block_invoke(34): 1 剩余: 5
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 4
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 2
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 1
//    -[DispatchTest saleTicket_nosafe]_block_invoke(34): 1 剩余: 3
//    -[DispatchTest saleTicket_nosafe]_block_invoke(40): 2 剩余: 0
}

- (void)saleTicket_safe {
    dispatch_queue_t que1 = dispatch_queue_create("beijing", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t que2 = dispatch_queue_create("shanghai", DISPATCH_QUEUE_SERIAL);
    
    self.semaphore = dispatch_semaphore_create(1); // 使信号量=1
    
    NSLog(@"begin sale");
    dispatch_async(que1, ^{
        while (self.total > 0) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER); //信号量-1=0,第1个线程进入执行操作,其它线程过来再-1=-1,等待
            NSLog(@"1 剩余: %ld", (long)self.total);
            self.total--;
            dispatch_semaphore_signal(self.semaphore);//当前线程操作完成,信号量+1=0,其它线程可以进入
        }
    });

    dispatch_async(que2, ^{
        while (self.total > 0) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER); //信号量-1=0,第1个线程进入执行操作,其它线程过来再-1=-1,等待
            NSLog(@"2 剩余: %ld", (long)self.total);
            self.total--;
            dispatch_semaphore_signal(self.semaphore);//当前线程操作完成,信号量+1=0,其它线程可以进入
        }
    });
    
    
//    -[DispatchTest saleTicket_safe](64): begin sale
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 20
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 19
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 18
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 17
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 16
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 15
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 14
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 13
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 12
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 11
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 10
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 9
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 8
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 7
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 6
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 5
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 4
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 3
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 2
//    -[DispatchTest saleTicket_safe]_block_invoke(68): 1 剩余: 1
//    -[DispatchTest saleTicket_safe]_block_invoke_2(77): 2 剩余: 0
}
- (void)sale {
    while (self.total > 0) {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER); //信号量-1=0,第1个线程进入执行操作,其它线程过来再-1=-1,等待
        NSLog(@"剩余: %ld", (long)self.total);
        self.total--;
        dispatch_semaphore_signal(self.semaphore);//当前线程操作完成,信号量+1=0,其它线程可以进入
    }
}

- (void)saleTicket_safe_three {
    
    dispatch_queue_t que1 = dispatch_queue_create("beijing", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t que2 = dispatch_queue_create("shanghai", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t que3 = dispatch_queue_create("jiangsu", DISPATCH_QUEUE_SERIAL);
    
    self.semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(que1, ^{
        while (self.total > 0) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"A , %@, 剩余: %ld", [NSThread currentThread], (long)self.total);
            self.total--;
            dispatch_semaphore_signal(self.semaphore);
        }
    });
    dispatch_async(que2, ^{
        while (self.total > 0) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"B , %@, 剩余: %ld", [NSThread currentThread], (long)self.total);
            self.total--;
            dispatch_semaphore_signal(self.semaphore);
        }
    });
    dispatch_async(que3, ^{
        while (self.total > 0) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"C , %@, 剩余: %ld", [NSThread currentThread], (long)self.total);
            self.total--;
            dispatch_semaphore_signal(self.semaphore);
        }
    });
}


// MARK: -

// MARK: 信号量 semaphore, ≥ 0 执行
// < 0 阻塞, ≥ 0 执行
+ (void)semaphore {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"begin %@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1 %@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
        NSLog(@"2 %@",[NSThread currentThread]);
    });
    
    NSLog(@"3 %@",[NSThread currentThread]);
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"4 %@",[NSThread currentThread]);
    // begin 3 1 4 2 / begin 3 1 2 4
//    +[DispatchTest semaphore](25): begin <NSThread: 0x600002d4cb40>{number = 1, name = main}
//    +[DispatchTest semaphore](32): 3 <NSThread: 0x600002d4cb40>{number = 1, name = main}
//    +[DispatchTest semaphore]_block_invoke(27): 1 <NSThread: 0x600002d1e100>{number = 7, name = (null)}
//    +[DispatchTest semaphore](34): 4 <NSThread: 0x600002d4cb40>{number = 1, name = main}
//    +[DispatchTest semaphore]_block_invoke(29): 2 <NSThread: 0x600002d1e100>{number = 7, name = (null)}
}
+ (void)semaphore_mainqueue {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"begin %@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1 %@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
        NSLog(@"2 %@",[NSThread currentThread]);
    });
    
    NSLog(@"3 %@",[NSThread currentThread]);
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER); // 阻塞主线程
    NSLog(@"4 %@",[NSThread currentThread]);
    
    // !!!: 被阻塞
//    +[DispatchTest semaphore_mainqueue](45): begin <NSThread: 0x600003d44a40>{number = 1, name = main}
//    +[DispatchTest semaphore_mainqueue](52): 3 <NSThread: 0x600003d44a40>{number = 1, name = main}
}

// MARK: semaphore 同一线程会被阻塞
//+[DispatchTest thaction](67): begin <NSThread: 0x6000019974c0>{number = 8, name = (null)}
//+[DispatchTest thaction](70): 3 <NSThread: 0x6000019974c0>{number = 8, name = (null)}
+ (void)semaphore_one_thread {
    NSThread * th = [[NSThread alloc] initWithTarget:self selector:@selector(thaction) object:nil];
    [th start];
}
+(void)thaction {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    NSLog(@"begin %@",[NSThread currentThread]);
    [self performSelector:@selector(sig:) onThread:[NSThread currentThread] withObject:sem waitUntilDone:NO];
   
    NSLog(@"3 %@",[NSThread currentThread]);
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"4 %@",[NSThread currentThread]);
}
+(void)sig:(id)obj {
    dispatch_semaphore_t sem = (dispatch_semaphore_t)obj;
    NSLog(@"1 %@",[NSThread currentThread]);
    dispatch_semaphore_signal(sem);
    NSLog(@"2 %@",[NSThread currentThread]);
}

+ (void)semaphore_globalqueue {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"begin %@",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1 %@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
        NSLog(@"2 %@",[NSThread currentThread]);
    });
    
    NSLog(@"3 %@",[NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSLog(@"4 %@",[NSThread currentThread]);
    });
    // begin 3 1 2 4 / begin 3 1 4 2
//    +[DispatchTest semaphore_globalqueue](61): begin <NSThread: 0x6000009c0b40>{number = 1, name = main}
//    +[DispatchTest semaphore_globalqueue](68): 3 <NSThread: 0x6000009c0b40>{number = 1, name = main}
//    +[DispatchTest semaphore_globalqueue]_block_invoke(63): 1 <NSThread: 0x60000098c240>{number = 3, name = (null)}
//    +[DispatchTest semaphore_globalqueue]_block_invoke(65): 2 <NSThread: 0x60000098c240>{number = 3, name = (null)}
//    +[DispatchTest semaphore_globalqueue]_block_invoke_2(71): 4 <NSThread: 0x6000009fb000>{number = 6, name = (null)}
}
+ (void)semaphore_globalqueue_2 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        NSLog(@"begin %@",[NSThread currentThread]);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            NSLog(@"1 %@",[NSThread currentThread]);
            dispatch_semaphore_signal(sem);
            NSLog(@"2 %@",[NSThread currentThread]);
        });
        
        NSLog(@"3 %@",[NSThread currentThread]);
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSLog(@"4 %@",[NSThread currentThread]);
    });
//    +[DispatchTest semaphore_globalqueue_2]_block_invoke(87): begin <NSThread: 0x600001ccf580>{number = 7, name = (null)}
//    +[DispatchTest semaphore_globalqueue_2]_block_invoke(94): 3 <NSThread: 0x600001ccf580>{number = 7, name = (null)}
//    +[DispatchTest semaphore_globalqueue_2]_block_invoke_2(89): 1 <NSThread: 0x600001cb7a80>{number = 6, name = (null)}
//    +[DispatchTest semaphore_globalqueue_2]_block_invoke_2(91): 2 <NSThread: 0x600001cb7a80>{number = 6, name = (null)}
//    +[DispatchTest semaphore_globalqueue_2]_block_invoke(96): 4 <NSThread: 0x600001ccf580>{number = 7, name = (null)}
}


// MARK: 线程组 group
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

// MARK: 迭代 apply

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

// MARK: 常规用法

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




@end
