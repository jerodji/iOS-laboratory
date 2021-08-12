//
//  Student.h
//  排序
//
//  Created by Jerod on 2017/12/20.
//  Copyright © 2017年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (assign, nonatomic) NSInteger age;

- (NSComparisonResult)compareWithStu:(Student *)stu;

@end
