//
//  ViewController.m
//  runloop卡顿监控
//
//  Created by Jerod on 2021/7/15.
//

#import "ViewController.h"
#import "LagMonitor.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.systemPinkColor;
    
    [[LagMonitor shared] beginMonitor];
}


static void runloopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"RunLoop Before Waiting");
    [NSThread sleepForTimeInterval:2];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // MARK: 正常的任务超时
    [NSThread sleepForTimeInterval:0.1];
    [self task];
    
    // MARK: timer任务超时
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"begin timer");
//        [NSThread sleepForTimeInterval:0.3];
//    }];
    
    
    // MARK: kCFRunLoopBeforeWaiting 任务超时
//    CFRunLoopObserverContext context = {
//        0,
//        (__bridge void*)self,
//        &CFRetain,
//        &CFRelease,
//        NULL
//    };
//    static CFRunLoopObserverRef observer;
//    observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, YES, 0, &runloopObserverCallback, &context);
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
}

- (void)task {
    [NSThread sleepForTimeInterval:0.1];
//    sleep(0.2);
}


@end
