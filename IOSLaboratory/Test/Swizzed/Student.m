//
//  Student.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import "Student.h"
#import "RuntimeTool.h"

@implementation Student

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [RuntimeTool simple_methodSwizzlingWithClass:self oriSEL:@selector(foo) swiSEL:@selector(euu)];
//        [RuntimeTool better_methodSwizzlingWithClass:self oriSEL:@selector(foo) swiSEL:@selector(euu)];
        [RuntimeTool swizzlingInstanceMethodWithClass:self originSEL:@selector(foo) swizzleSEL:@selector(euu)];
    });
}

//- (void)foo {
//    NSLog(@"Student foo");
////    [self foo];
//}

- (void)euu {
    NSLog(@"Student euu");
//    [self euu];
}

@end
