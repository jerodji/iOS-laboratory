//
//  LagMonitor.m
//  runloop卡顿监控
//
//  Created by Jerod on 2021/7/15.
//

#import "LagMonitor.h"
#import "LXDBacktraceLogger.h"

// 定义延迟时间 毫秒
static int64_t const OUT_TIME = 100 * NSEC_PER_MSEC;
// before wait 的超时时间
static NSTimeInterval const WAIT_TIME = 0.5;

@interface LagMonitor () {
    @public
    CFRunLoopObserverRef observer;
    CFRunLoopActivity currentActivity;
    dispatch_semaphore_t semaphore;
    BOOL isMonitoring;
}
@end

static void runloopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    //LagMonitor * monitor = (__bridge LagMonitor*)info;
    [LagMonitor shared]->currentActivity = activity;
    
    dispatch_semaphore_t sema = [LagMonitor shared]->semaphore;
    dispatch_semaphore_signal(sema);
}

@implementation LagMonitor

+ (instancetype)shared {
    static id ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[super allocWithZone:NSDefaultMallocZone()] init];
    });
    return ins;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shared];
}

- (void)dealloc {
    [self endMonitor];
}

- (void)beginMonitor {
    
    if ([LagMonitor shared]->isMonitoring) return;
    
    [LagMonitor shared]->isMonitoring = YES;
    
    // 创建观察者
    CFRunLoopObserverContext context = {
        0,
        (__bridge void*)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    //static CFRunLoopObserverRef observer;
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopObserverCallback, &context);
    
    // 观察主线程
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    // 在子线程中监控卡顿
    semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 开启持续的loop来监控
        while ([LagMonitor shared]->isMonitoring) {
            if ([LagMonitor shared]->currentActivity == kCFRunLoopBeforeWaiting)
            {
                // 处理休眠前事件观测
                __block BOOL timeOut = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    timeOut = NO; // timeOut任务
                });
                [NSThread sleepForTimeInterval:WAIT_TIME];
                // WAIT_TIME 时间后,如果 timeOut任务 任未执行, 则认为主线程前面的任务执行时间过长导致卡顿
                if (timeOut) {
                    [LXDBacktraceLogger lxd_logMain];
                }
            }
            else
            {
                // 处理 Timer,Source,唤醒后事件
                // 同步等待时间内,接收到信号result=0, 超时则继续往下执行并且result!=0
                long result = dispatch_semaphore_wait([LagMonitor shared]->semaphore, dispatch_time(DISPATCH_TIME_NOW, OUT_TIME));
                if (result != 0) { // 超时
                    if (![LagMonitor shared]->observer) {
                        [[LagMonitor shared] endMonitor];
                        continue;
                    }
                    if ([LagMonitor shared]->currentActivity == kCFRunLoopBeforeSources ||
                        [LagMonitor shared]->currentActivity == kCFRunLoopAfterWaiting  ||
                        [LagMonitor shared]->currentActivity == kCFRunLoopBeforeTimers) {
                        
                        [LXDBacktraceLogger lxd_logMain];
                    }
                }
            }
        }
    });
    
}

- (void)endMonitor {
    if (!observer) return;
    if (!isMonitoring) return;
    isMonitoring = NO;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    observer = nil;
}

@end
