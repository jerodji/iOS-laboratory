//
//  Student.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import "Student.h"
#import "JJRuntimeTool.h"

@implementation Student

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [RuntimeTool simple_methodSwizzlingWithClass:self oriSEL:@selector(foo) swiSEL:@selector(euu)];
//        [RuntimeTool better_methodSwizzlingWithClass:self oriSEL:@selector(foo) swiSEL:@selector(euu)];
        
//        [JJRuntimeTool swizzlingInstanceMethodWithClass:self originSEL:@selector(foo) swizzleSEL:@selector(euu) force:YES];
        [JJRuntimeTool swizzlingClassMethodWithClass:[Student class] originSEL:@selector(bar1) swizzleSEL:@selector(bar2)];
    });
}

//- (void)foo {
//    NSLog(@"Student foo");
////    [self foo];
//}

- (void)euu {
    NSLog(@"Student euu");
    [self euu];
    
    
}


//+ (void)bar1 {
//    NSLog(@"bar1");
//}

+ (void)bar2 {
    NSLog(@"bar2");
}


@end
