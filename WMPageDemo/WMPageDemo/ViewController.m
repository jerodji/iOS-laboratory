//
//  ViewController.m
//  WMPageDemo
//
//  Created by Jerod on 2020/12/18.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index % 3) {
        case 0: return @"LIST";
        case 1: return @"INTRODUCTION";
        case 2: return @"IMAGES";
    }
    return @"NONE";
}



@end
