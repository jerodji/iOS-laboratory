//
//  ViewController.m
//  tableView加载图片--用runloop性能优化
//
//  Created by Jerod on 2018/1/9.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "ViewController.h"

typedef void (^TaskBLK)(void);

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSMutableArray * taskArray; //任务队列
@property (nonatomic, assign) NSUInteger maxQueue; //最大任务数
@end

@implementation ViewController

#pragma mark-
static NSString * CELLID = @"cellid";

- (void)timerAction {
    //什么也不做, 不会影响性能(影响很小很小很小,只会占用一点点CPU)
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    _taskArray = [NSMutableArray array];
    _maxQueue = 600;
    //为了让runloop一直处于运行状态
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    [self addRunloopObserver];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    
//    //30s 60M, 再一次runloop循环中全部渲染,会卡顿
//    for (int i=0; i<10; i++) {
//        for (int j=0; j<10; j++) {
//            UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"akn.jpg"]];
//            imgView.frame = CGRectMake(i*32, j*10, 32, 10);
//            [cell.contentView addSubview:imgView];
//        }
//    }
    
    
    //一次runloop循环渲染一个,不卡顿
    //30s 16M,
    for (int i=0; i<10; i++) {
        for (int j=0; j<10; j++) {
            [self addTask:^{
                UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"akn.jpg"]];
                imgView.frame = CGRectMake(i*32, j*10, 32, 10);
                [cell.contentView addSubview:imgView];
            }];
        }
    }
    
    return cell;
}

#pragma mark- RunLoop优化 C语言
//利用runloop，每次循环执行一段任务（每次循环进行一次渲染）

//添加任务到队列中
- (void)addTask:(TaskBLK)task {
    [self.taskArray addObject:task];
    //任务超出最大任务数限制的时候,移除最先添加的任务
    if (self.taskArray.count > self.maxQueue) {
        [self.taskArray removeObjectAtIndex:0];
    }
}

//observer回调时会传入3个参数
static void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
//    NSLog(@"laila");

    //取出任务队列
    //我们需要的东西在info中
//    NSLog(@"%@",info); - ViewController
    ViewController * vc = (__bridge ViewController*)info;
    
    if (vc.taskArray.count==0) {
        return;
    }
    //取出一个任务
    TaskBLK task = vc.taskArray.firstObject;
    task(); //执行任务(block)
    [vc.taskArray removeObjectAtIndex:0];
}

- (void)addRunloopObserver {
    //拿到当前runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //定义一个上下文;
    //是一个结构体, void * 任意东西都可以传,类似id
    CFRunLoopObserverContext context = {
        0,
        (__bridge void*)self, // void *    info; 这个参数很重要!!!
        &CFRetain,//cf的引用计数+1
        &CFRelease, //引用计数-1
        NULL
    };
    
    //定义一个观察者
    //用static，因为只需要一个
    static CFRunLoopObserverRef observer;
    observer = CFRunLoopObserverCreate(
                               NULL,
                               kCFRunLoopAfterWaiting,/*在什么时候监听*/
                               YES,/*需要循环监听*/
                               0,
                               &callBack,/*回调函数,回调时有3个参数*/
                               &context );
    
    //添加runloop观察者
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
    
    //在C中 create 需要release,他不归ARC管理
    //CF函数需要调用 CFRelease释放内存
    CFRelease(observer);
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
