//
//  ViewController.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/4/29.
//

#import "ViewController.h"
#import "DispatchTest.h"
#import "OptionTest.h"
#import "ThreadLock.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnAction:(UIButton *)sender {
//    NSLog(@"%s -------------------------------------------------------------",__func__);
    printf("\n");
//    [DispatchTest begin];
//    [OptionTest begin];
    [ThreadLock begin];
    
    
    
    
}


@end
