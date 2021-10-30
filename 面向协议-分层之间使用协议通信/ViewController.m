//
//  ViewController.m
//  面向协议-分层之间使用协议通信
//
//  Created by Jerod on 2021/10/18.
//

#import "ViewController.h"
#import "SecondModule.h"

@interface ViewController ()
@property (nonatomic, strong) SecondModule *sm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemPinkColor];
    self.sm = [[SecondModule alloc] initWithName:@"Don"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.sm hello];
}


@end
