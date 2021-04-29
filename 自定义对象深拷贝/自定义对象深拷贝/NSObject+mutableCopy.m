//
//  NSObject+mutableCopy.m
//  自定义对象深拷贝
//
//  Created by Jerod on 2021/3/28.
//

#import "NSObject+mutableCopy.h"
#import <objc/runtime.h>

@implementation NSObject (mutableCopy)

- (id)mutableCopyWithZone:(NSZone *)zone
{
    id NEW_MODEL = [[self class] new];

    unsigned int count = 0;
    Ivar * ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char * name = ivar_getName(ivar);
        NSString * _key = [NSString stringWithUTF8String:name];
        id _val = [self valueForKey:_key];
        [NEW_MODEL setValue:_val forKey:_key];
    }
    free(ivarList);

    return NEW_MODEL;
}

@end
