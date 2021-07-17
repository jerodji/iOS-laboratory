//
//  JJLagMonitor.m
//  runloop卡顿监控
//
//  Created by Jerod on 2021/7/15.
//

#import "JJLagMonitor.h"
#import "LXDBacktraceLogger.h"

// 定义延迟时间 毫秒
static int64_t const OUT_TIME = 100 * NSEC_PER_MSEC;
// before wait 的超时时间
static NSTimeInterval const WAIT_TIME = 0.5;

@interface JJLagMonitor () {
    @public
    CFRunLoopObserverRef observer;
    CFRunLoopActivity currentActivity;
    dispatch_semaphore_t semaphore;
    BOOL isMonitoring;
}
@end

static void runloopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    //JJLagMonitor * monitor = (__bridge JJLagMonitor*)info;
    [JJLagMonitor shared]->currentActivity = activity;
    
    dispatch_semaphore_t sema = [JJLagMonitor shared]->semaphore;
    dispatch_semaphore_signal(sema);
}

@implementation JJLagMonitor

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
    
    if ([JJLagMonitor shared]->isMonitoring) return;
    
    [JJLagMonitor shared]->isMonitoring = YES;
    
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
        while ([JJLagMonitor shared]->isMonitoring) {
            if ([JJLagMonitor shared]->currentActivity == kCFRunLoopBeforeWaiting)
            {
                __block BOOL timeOut = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    timeOut = NO;
                });
                [NSThread sleepForTimeInterval:WAIT_TIME];
                if (timeOut) {
                    [LXDBacktraceLogger lxd_logMain];
                }
            }
            else
            {
                // 同步等待时间内,接收到信号result=0, 超时则继续往下执行并且result!=0
                long result = dispatch_semaphore_wait([JJLagMonitor shared]->semaphore, dispatch_time(DISPATCH_TIME_NOW, OUT_TIME));
                if (result != 0) { // 超时
                    if (![JJLagMonitor shared]->observer) {
                        [[JJLagMonitor shared] endMonitor];
                        continue;
                    }
                    if ([JJLagMonitor shared]->currentActivity == kCFRunLoopBeforeSources ||
                        [JJLagMonitor shared]->currentActivity == kCFRunLoopAfterWaiting  ||
                        [JJLagMonitor shared]->currentActivity == kCFRunLoopBeforeTimers) {
                        
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
