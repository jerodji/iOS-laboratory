//
//  main.m
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface YZPerson : NSObject
@property (nonatomic, assign) int age;
@end
@implementation YZPerson
@end

typedef void (^YZBlock)(void);

int main(int argc, char * argv[]) {
//    NSString * appDelegateClassName;
//    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
//        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//    }
//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    
    @autoreleasepool {
//        YZBlock block;
//
//        {
//                YZPerson *person = [[YZPerson alloc]init];
//                person.age = 10;
//
//                block = ^{
//                        NSLog(@"---------%d", person.age);
//                };
//
//                 NSLog(@"block.class = %@",[block class]);
//        }
//        NSLog(@"block销毁");
//
//        block();
        
        
        NSMutableArray * arr = [NSMutableArray arrayWithArray:@[@1]];
        void (^Jblock)(void) = ^ {
            [arr addObject:@2];
            NSLog(@"%@", arr);
        };
        Jblock();
    }
    return 0;
    
    
}
