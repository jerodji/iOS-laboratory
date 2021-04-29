//
//  ViewController.m
//  消息转发
//
//  Created by Jerod on 2021/4/11.
//

#import "ViewController.h"
#import "objc/runtime.h"


@interface Person: NSObject
@end
@implementation Person
- (void)foo {
    NSLog(@"Person -foo");//Person的foo函数
}
@end



@interface ViewController ()
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemPinkColor;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(foo)];
}
// YES if the method was found and added to the receiver, otherwise NO.
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo)) {
        NSLog(@"resolveInstanceMethod class_addMethod, %s", sel_getName(sel));
        class_addMethod([self class], sel, (IMP)myFunction, "v@:");
        return YES;
    }
    NSLog(@"resolveInstanceMethod NO, %s", sel_getName(sel));
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo)) {
        NSLog(@"forwardingTargetForSelector Person");
        return [Person new];
    }
    NSLog(@"forwardingTargetForSelector Super");
    return [super forwardingTargetForSelector:aSelector];
}

void myFunction(id self, SEL _cmd) {
    NSLog(@"myFunction");
}
@end

//return YES
/*
 resolveInstanceMethod class_addMethod, foo
 myFunction
 myFunction
 myFunction
 */

//return NO
/**
 resolveInstanceMethod class_addMethod, foo
 myFunction
 myFunction
 myFunction
 */
