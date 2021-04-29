//
//  ViewController.m
//  RACDemo
//
//  Created by Jerod on 2020/8/12.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import "ViewController.h"
#import "View.h"
#import "ViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface ViewController ()
@property (nonatomic, strong) View *v;
@property (nonatomic, strong) ViewModel *vm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _v = [[View alloc] initWithFrame:CGRectMake(88, 88, 300, 300)];
    [self.view addSubview:_v];
    
//    NSLog(@"== %s", __FUNCTION__);
    [[_v rac_signalForSelector:@selector(clickAction:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"接收到了参数 %@", [x objectAtIndex:0]);
    }];
    
}


@end
