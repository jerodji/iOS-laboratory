//
//  main.m
//  二级指针妙用
//
//  Created by Jerod on 2020/8/18.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
+ (void)getAccount:(NSString **)str;
@end

@implementation User

+ (void)getAccount:(NSString **)str {
    NSLog(@"str = %@", *str);
    
    *str = @"3333";
}

@end


int main(int argc, const char * argv[]) {
    
    NSString *s = @"11";
    
    [User getAccount:&s];
    
    NSLog(@"== = %@", s);
    
    return 0;
}




