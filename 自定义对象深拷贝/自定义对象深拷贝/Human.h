//
//  Human.h
//  自定义对象深拷贝
//
//  Created by Jerod on 2021/3/28.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject

@property (nonatomic, assign) int age;

@property (nonatomic, strong) Human *mate;

@end

