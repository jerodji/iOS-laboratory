//
//  ArrayRemoveDuplicate.h
//  Algorithm
//
//  Created by Jerod on 17/5/25.
//  Copyright © 2017年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayRemoveDuplicate : NSObject

/* 开辟行的内存空间，然后判断是否存在；若不存在添加到数组，最终结果顺序不变。
 效率：时间复杂度为O(n^2)。 */
- (void)planOne;

/*
 * 利用NSDictionary去重
 字典在设置key-value时，若已存在则更新值，若不存在则插入值，然后获取allValues。
 若不要求有序，则可以采用此种方法。若要求有序，还得进行排序。
 效率分析：只需要一个循环就可以完成放入字典，若不要求有序，时间复杂度为O(n)。若要求排序，则效率与排序算法有关：
 */
- (void)planTwo;

void arrayRemoveDuplicate();


@end
