//
//  ViewController.m
//  self引用
//
//  Created by Jerod on 2020/8/17.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import "ViewController.h"
#import "MKView.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *ui;
@property (nonatomic, strong) MKView *vi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vi = [[MKView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    _vi.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_vi];
    
    _ui = [[UIView alloc] initWithFrame:CGRectMake(100, 320, 200, 200)];
    _ui.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_ui];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.vi excuteBlock:^(BOOL bk) {
        self.ui.backgroundColor = [UIColor systemPinkColor];
    }];
}




@end
