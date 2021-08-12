//
//  ViewController.m
//  排序
//
//  Created by Jerod on 2017/12/18.
//  Copyright © 2017年 Jerod. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self BubbleSort];
//    [self selectionSort];
//    [self sortOne];
    [self sortTwo];

}

//冒泡排序
- (void)BubbleSort {
    NSMutableArray *arrM = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,@7,@9,@8,@0,@6,nil];
    for (int i = 0; i < arrM.count; ++i) {
        for (int j = 0; j < arrM.count-1; ++j) {
            if (arrM[j] > arrM[j+1]) {
                [arrM exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    NSLog(@"最终结果：%@",arrM);
}

//选择排序
- (void)selectionSort {
    NSMutableArray * mArr = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];
    for (int i=0; i < mArr.count; i++) {
        for (int j=i+1; j < mArr.count; j++) {
            if ( mArr[i] < mArr[j]) {
                [ mArr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    NSLog(@"%@", mArr);
}

#pragma mark- 数组排序
//第一种，利用数组的sortedArrayUsingComparator调用 NSComparator ，obj1和obj2指的数组中的对象
- (void)sortOne {
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *sortArray = [[NSArray alloc] initWithObjects:@"1",@"3",@"4",@"7",@"8",@"2",@"6",@"5",@"13",@"15",@"12",@"20",@"28",@"",nil];
    NSLog(@"排序前:%@",sortArray);
    
    //第一种排序
//    注意：
//    NSArray的排序方法是生成一个排好序的新数组。
//    NSMutableArray的排序可以直接对该数组进行排序sortUsingComparator:，也可以生成新数组sortedArrayUsingComparator: ，而原数组不变。
    NSArray *array = [sortArray sortedArrayUsingComparator:cmptr];
     NSLog(@"排序后:%@",array);
}

//第二种 排序方法 利用sortedArrayUsingFunction 调用 对应方法customSort，这个方法中的obj1和obj2分别是指数组中的对象。
- (void)sortTwo
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
//    for (int i=0; i<5; i++) {
        Student * stu = [Student new];
//        stu.age = arc4random_uniform(10)+10;//随机数
        stu.age = 21;
        [arr addObject:stu];
//    }
    
    Student * stu1 = [Student new];
    Student * stu2 = [Student new];
    Student * stu3 = [Student new];
    Student * stu4 = [Student new];
    stu1.age = 2;
    stu2.age = 19;
    stu3.age = 13;
    stu4.age = 14;
    [arr addObject:stu1];
    [arr addObject:stu2];
    [arr addObject:stu3];
    [arr addObject:stu4];
    
    
    //此处的sel应该理解为对数组中A对象调用自己的sel，传入值为B对象，同时返回值为NSComparisonResult
    [arr sortUsingSelector:@selector(compareWithStu:)];
    
    for (Student * s in arr) {
        NSLog(@"%ld",s.age);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
