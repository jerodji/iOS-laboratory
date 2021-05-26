//
//  OptionTest.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/13.
//

#import "OptionTest.h"




@interface OptionTest ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int total;
@end

@implementation OptionTest

+ (void)begin {
    OptionTest * t = [[OptionTest alloc] init];
    t.total = 5000;
//    [t queue];
//    [t block];
//    [t inv];
//    [NSThread detachNewThreadSelector:@selector(inv) toTarget:t withObject:@"ok"];
}



- (void)inv {
    NSInvocationOperation * op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocatAction:) object:@"tt"];
    [op start];
}

- (void)invocatAction:(id)obj {
    NSLog(@"a InvocationOperation --- %@, obj %@", [NSThread currentThread], obj);
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
    [b addExecutionBlock:^{
        NSLog(@"D , %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@"E , %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@"F , %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@"G , %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@"H , %@", [NSThread currentThread]);
    }];
    
    [b setCompletionBlock:^{
        NSLog(@"Completion , %@", [NSThread currentThread]);
    }];
    [b start];
}

- (void)queue {
//    NSOperationQueue * queue = [NSOperationQueue mainQueue];
    NSOperationQueue * queue = [NSOperationQueue new];
//    queue.maxConcurrentOperationCount = 1;
    
    NSInvocationOperation * a = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocatAction:) object:@{@"d":@"d"}];
    [a setCompletionBlock:^{
        NSLog(@"a Completion , %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation * b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" b 1 --- %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@" b 2 --- %@", [NSThread currentThread]);
    }];
    [b addExecutionBlock:^{
        NSLog(@" b 3 --- %@", [NSThread currentThread]);
    }];
    [b setCompletionBlock:^{
        NSLog(@"b Completion , %@", [NSThread currentThread]);
    }];
    
//    [a addDependency:b];//a依赖b
    
    [a setQueuePriority:NSOperationQueuePriorityLow];
    [b setQueuePriority:NSOperationQueuePriorityHigh];
    
    [queue addOperation:a];
    [queue addOperation:b];
    [queue addOperationWithBlock:^{
        NSLog(@" c 1 --- %@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@" c 2 --- %@", [NSThread currentThread]);
    }];
    
}




@end
