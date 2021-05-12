//
//  ViewController.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/4/29.
//

#import "ViewController.h"
#import "DispatchTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnAction:(UIButton *)sender {
    NSLog(@"%s",__func__);
    
    [DispatchTest begin];
}


@end
