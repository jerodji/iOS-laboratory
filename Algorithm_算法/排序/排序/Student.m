//
//  Student.m
//  排序
//
//  Created by Jerod on 2017/12/20.
//  Copyright © 2017年 Jerod. All rights reserved.
//

//descending 降
//Ascending  升

#import "Student.h"

@implementation Student
/** 排序规则
 1 升序
 2 降序
 */
- (NSComparisonResult)compareWithStu:(Student *)stu
{
//    NSLog(@"self.age %d, stu.age %d",self.age,stu.age);
    //按照升续排列
    if (self.age > stu.age){
        return NSOrderedDescending;// 1
//        return NSOrderedAscending;// 2
    }
    else if (self.age == stu.age){
        return NSOrderedSame;
    }
    else {
        return NSOrderedAscending;// 1
//        return NSOrderedDescending;// 2
    }
}

@end
