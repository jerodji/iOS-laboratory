//
//  ViewController.m
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//

#import "ViewController.h"
#import "AdPopUps.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    int age = 20;
//    void (^block)(void) =  ^{
//         NSLog(@"age is %d",age);
//    };
//    age = 25;
//           
//    block();
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    id<PopUpsProtocol> popUps = [[AdPopUps alloc] init];
    popUps.url = @"...";
    popUps.content = @"...";
    popUps.type = @"...";

    //show
    [popUps execute];

}


@end
