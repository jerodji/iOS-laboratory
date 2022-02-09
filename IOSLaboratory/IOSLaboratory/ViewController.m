//
//  ViewController.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/4/29.
//

#import "ViewController.h"
#import "ThreadLock.h"
#import "Student.h"
#import "JJRuntimeTool.h"

@interface ViewController ()

@end

@implementation ViewController

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [JJRuntimeTool swizzlingInstanceMethodWithClass:self originSEL:@selector(viewDidLoad) swizzleSEL:@selector(viewDidLoad1)];
//    });
//}
//
//+ (void)initialize
//{
//    if (self == [self class]) {
//        NSLog(@"%s", __func__);
//        [JJRuntimeTool swizzlingInstanceMethodWithClass:self originSEL:@selector(viewDidLoad) swizzleSEL:@selector(viewDidLoad2)];
//    }
//}

//- (void)viewDidLoad2 {
//    [super viewDidLoad];
//    NSLog(@"2222");
//    self.view.backgroundColor = UIColor.greenColor;
//    [self viewDidLoad2];
//}
//- (void)viewDidLoad1 {
//    [super viewDidLoad];
//    NSLog(@"1111");
//    self.view.backgroundColor = UIColor.redColor;
//    [self viewDidLoad1];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"0000");
    self.view.backgroundColor = UIColor.lightGrayColor;
}

- (IBAction)btnAction:(UIButton *)sender {

//    [ThreadLock begin];
//    ThreadLock * a = [ThreadLock new];
//    [a testCondition];
    
    Student * s = [Student new];
    NSLog(@"1");
    [s foo];
    
    NSLog(@"2");
    [s euu];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"3");
        Person *p = [Person new];
        [p foo];
    });
    
}

- (IBAction)swizzleClassMethod:(id)sender {
    [Student bar1];
    
    [Student bar2];
    
    [Person bar1];
    
    
}

@end
