//
//  RuntimeTool.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import "RuntimeTool.h"
#import <objc/runtime.h>

@implementation RuntimeTool

+ (void)simple_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL
{
    if (!cls) {
        NSLog(@"*** Class can't be nil : %s", __func__);
        return;
    }
    
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swiSEL);
    
    // !!!: exchange super's imp also, it's not you expected.
    method_exchangeImplementations(oriMethod, swiMethod);
}


+ (void)methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL
{
    if (!cls) {
        NSLog(@"*** Class can't be nil : %s", __func__);
        return;
    }
    
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swiSEL);
    
    // class_addMethod will add an override of a superclass's implementation, but will not replace an existing implementation in this class. To change an existing implementation, use method_setImplementation.
    // return YES if the method was added successfully, otherwise NO (for example, the class already contains a method with that name).
    BOOL success = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    
    if (success) {
        // cls replace swiSEL to oriIMP
        class_replaceMethod(cls, swiSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        
        NSLog(@"class %@ addMethod %@ success", NSStringFromClass(cls), NSStringFromSelector(oriSEL));
        
    } else {
        method_exchangeImplementations(oriMethod, swiMethod);
        
        NSLog(@"class %@ addMethod %@ failure", NSStringFromClass(cls), NSStringFromSelector(oriSEL));
    }
}

@end
