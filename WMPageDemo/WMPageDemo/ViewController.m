//
//  ViewController.m
//  WMPageDemo
//
//  Created by Jerod on 2020/12/18.
//

#import "ViewController.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleSizeNormal = 15;
    self.titleSizeSelected = 19;
    self.menuViewStyle = WMMenuViewStyleLine;
//        self.titleColorSelected = [UIColor blueColor];//设置选中文字颜色
//        self.progressColor = [UIColor whiteColor];
//        self.titleSizeSelected = 18;//设置选中文字大小
//    self.titleSizeNormal = 15;
    self.titleColorSelected = [UIColor blueColor];
    self.titleColorNormal = [UIColor grayColor];
    self.progressColor = [UIColor yellowColor];
    //self.showOnNavigationBar = YES;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
//    self.titleSizeSelected = 19;
    self.menuView.backgroundColor = [UIColor systemPinkColor];
    
}

/**
 Implement this datasource method, in order to customize your own contentView's frame

 @param pageController The container controller
 @param contentView The contentView, each is the superview of the child controllers
 @return The frame of the contentView
 */
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 20+50, ScreenWidth, ScreenHeight - 100);
}

/**
 Implement this datasource method, in order to customize your own menuView's frame

 @param pageController The container controller
 @param menuView The menuView
 @return The frame of the menuView
 */
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(100, 20, ScreenWidth - 200, 50);
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"LIST";
        case 1: return @"INTRODUCTION";
        case 2: return @"IMAGES";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            UIViewController * v = [[UIViewController alloc] init];
            v.view.backgroundColor = [UIColor greenColor];
            return v;
        } break;
        case 1:
        {
            UIViewController * v = [[UIViewController alloc] init];
            v.view.backgroundColor = [UIColor purpleColor];
            return v;
        } break;
        default:{
            UIViewController * v = [[UIViewController alloc] init];
            v.view.backgroundColor = [UIColor orangeColor];
            return v;
        }
            break;
    }
    return [[UIViewController alloc] init];
}




@end
