//
//  ViewController.m
//  frame和bounds
//
//  Created by Jerod on 2021/4/2.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [view1 setBounds:CGRectMake(-30, -30, 100, 100)];
    view1.backgroundColor = [UIColor systemPinkColor];
    [self.view addSubview:view1];
    NSLog(@"view1 frame:%@========view1 bounds:%@",NSStringFromCGRect(view1.frame),NSStringFromCGRect(view1.bounds));
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view2.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.5];
    [view1 addSubview:view2];//添加到view1上,[此时view1坐标系左上角起点为(-30,-30)]
    NSLog(@"view2 frame:%@========view2 bounds:%@",NSStringFromCGRect(view2.frame),NSStringFromCGRect(view2.bounds));
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view1 addGestureRecognizer:tap];
}

- (void)tapAction {
    NSLog(@"%s", __func__);
}

@end
