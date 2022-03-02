//
//  main.m
//  TestAppDelegate
//
//  Created by CN210208396 on 2022/3/1.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TTAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([TTAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
