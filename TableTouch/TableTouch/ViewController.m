//
//  ViewController.m
//  TableTouch
//
//  Created by Jerod on 2020/10/18.
//

#import "ViewController.h"
#import "CoverView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton * b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(300, 88, 50, 50);
    b.backgroundColor = UIColor.systemPinkColor;
    [b addTarget:self action:@selector(clickedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

- (void)clickedAction {
    CoverView *c = [CoverView new];
    c.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:c];
}


@end
