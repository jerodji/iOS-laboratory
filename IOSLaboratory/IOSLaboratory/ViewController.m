//
//  ViewController.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/4/29.
//

#import "ViewController.h"
#import "ThreadLock.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
}

- (IBAction)btnAction:(UIButton *)sender {

//    [ThreadLock begin];
//    ThreadLock * a = [ThreadLock new];
//    [a testCondition];
    
    Student * s = [Student new];
    [s foo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"---------");
        Person *p = [Person new];
        [p foo];
    });
    
}


@end
