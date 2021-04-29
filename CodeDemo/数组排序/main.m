//
//  main.m
//  数组排序
//
//  Created by Jerod on 2020/9/9.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    // 降序
    NSArray *originArray=@[@2,@5,@4,@1,@3,@7,@6];
    NSArray *resultArray=[originArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue]>[obj2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    NSLog(@"%@>>>数组降序",resultArray);
    
    
    // 升序
    NSArray *a=@[@2,@5,@4,@1,@3,@7,@6];
        NSArray *r=[a sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 integerValue]>[obj2 integerValue]) {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
    //        return [[NSNumber numberWithInteger:[obj1 integerValue]] compare:[NSNumber numberWithInteger:[obj2 integerValue]]];
        }];
        NSLog(@"%@>>>数组升序",r);
    
    return 0;
}


