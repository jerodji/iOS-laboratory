//
//  ViewController.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/4/29.
//

#import "ViewController.h"
#import "ThreadLock.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
}

- (IBAction)btnAction:(UIButton *)sender {

//    [ThreadLock begin];
    ThreadLock * a = [ThreadLock new];
    [a testCondition];
    
    
}


@end
