//
//  ArrayRemoveDuplicate.m
//  Algorithm
//
//  Created by Jerod on 17/5/25.
//  Copyright © 2017年 Jerod. All rights reserved.
//

#import "ArrayRemoveDuplicate.h"

@implementation ArrayRemoveDuplicate

/* 开辟行的内存空间，然后判断是否存在；若不存在添加到数组，最终结果顺序不变。
 效率：时间复杂度为O(n^2)。 */
- (void)planOne
{
    NSArray *array = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSString *item in array)
    {
        // 调用-containsObject:本质也是要循环去判断，因此本质上是双层遍历
        // 时间复杂度为O ( n^2 )而不是O (n)
        if (![resultArray containsObject:item]) {
            [resultArray addObject:item];
        }
        
        
        
    }
    
}

/*
 * 利用NSDictionary去重
 字典在设置key-value时，若已存在则更新值，若不存在则插入值，然后获取allValues。
 若不要求有序，则可以采用此种方法。若要求有序，还得进行排序。
 效率分析：只需要一个循环就可以完成放入字典，若不要求有序，时间复杂度为O(n)。若要求排序，则效率与排序算法有关：
 */
- (void)planTwo
{
    NSArray *array = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];
    
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithCapacity:array.count];
    for (NSString *item in array) {
        [resultDict setObject:item forKey:item];
    }
    NSArray *resultArray = resultDict.allValues;
}

void arrayRemoveDuplicate() {
    NSArray *array = @[@"5", @"9",@"3", @"3", @"4", @"6", @"1",@"2",@"4"];
    
    //NSSet* set = [NSSet setWithArray:array];
    //NSArray *resultArray = [set allObjects];
    //NSLog(@"%@", resultArray);
    //
    //resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    //    NSString *item1 = obj1;
    //    NSString *item2 = obj2;
    //    return [item1 compare:item2 options:NSLiteralSearch];
    //}];
    //NSLog(@"%@", resultArray);
    
    
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:array];
    NSLog(@"%@", set.array);
}








@end
