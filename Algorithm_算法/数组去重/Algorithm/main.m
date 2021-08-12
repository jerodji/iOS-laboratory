//
//  main.m
//  Algorithm
//
//  Created by Jerod on 16/11/28.
//  Copyright © 2016年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArrayRemoveDuplicate.h"

//#define MIN(a,b) (a <= b) ? a : b;

long minAB(long a, long b);
void timeStyle();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        arrayRemoveDuplicate();
        
//        long s = MIN(3, 2);
//        long x = MAX(41, 6);
//        NSLog(@"%ld",x);
        
        
    }
    return 0;
}

long minAB(long a, long b)
{
    return (a <= b) ? a : b;
}

void timeStyle()
{
    NSString* timeStr = @"2015-04-10";
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone defaultTimeZone];
    NSDate* date = [formatter dateFromString:timeStr];
    // 2015-04-09 16:00:00 +0000
    NSLog(@"%@", date);
}









