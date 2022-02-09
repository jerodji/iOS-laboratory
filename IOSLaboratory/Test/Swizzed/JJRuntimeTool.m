//
//  RuntimeTool.m
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import "JJRuntimeTool.h"
#import <objc/runtime.h>


@implementation JJRuntimeTool

/// exchange super's imp also, it's not you expected.
//+ (void)simple_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL
//{
//    if (!cls) {
//        NSLog(@"*** Class can't be nil : %s", __func__);
//        return;
//    }
//
//    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
//    Method swiMethod = class_getInstanceMethod(cls, swiSEL);
//
//    // !!!: exchange super's imp also, it's not you expected.
//    method_exchangeImplementations(oriMethod, swiMethod);
//}


/// swizzling cls only, no affect to super class. but not the best
// + (void)better_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL
// {
//     if (!cls) {
//         NSLog(@"*** Class can't be nil : %s", __func__);
//         return;
//     }

//     Method oriMethod = class_getInstanceMethod(cls, oriSEL);
//     Method swiMethod = class_getInstanceMethod(cls, swiSEL);

//     BOOL success = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));

//     if (success) {
//         class_replaceMethod(cls, swiSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
//     } else {
//         method_exchangeImplementations(oriMethod, swiMethod);
//     }
// }


// MARK: exchange instance method

+ (void)swizzlingInstanceMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL
{
    [self swizzlingInstanceMethodWithClass:cls originSEL:oriSEL swizzleSEL:swiSEL force:YES];
}

+ (void)swizzlingInstanceMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL force:(BOOL)isForce
{
    if (!cls) {
        NSLog(@"swizzling: ❌ Class can't be nil : %s", __func__);
        //NSAssert(NO, @"swizzling: ❌ Class can't be nil : %s", __func__);
        return;
    }
    
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swiSEL);
    
    [self _exchangeWithClass:cls originSEL:oriSEL originMethod:oriMethod swizzleSEL:swiSEL swizzleMethod:swiMethod force:isForce flag:@"-"];
}


// MARK: exchange class method

+ (void)swizzlingClassMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL
{
    [self swizzlingClassMethodWithClass:cls originSEL:oriSEL swizzleSEL:swiSEL force:YES];
}

+ (void)swizzlingClassMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL force:(BOOL)isForce
{
    if (!cls) {
        NSLog(@"swizzling: ❌ Class can't be nil : %s", __func__);
        //NSAssert(NO, @"swizzling: ❌ Class can't be nil : %s", __func__);
        return;
    }
    
    Method oriMethod = class_getClassMethod(cls, oriSEL);
    Method swiMethod = class_getClassMethod(cls, swiSEL);
    
    const char * metaName = NSStringFromClass(cls).UTF8String;
    Class metaClass = objc_getMetaClass(metaName);
    
    [self _exchangeWithClass:metaClass originSEL:oriSEL originMethod:oriMethod swizzleSEL:swiSEL swizzleMethod:swiMethod force:isForce flag:@"+"];
}

// MARK: exchange method
+ (void)_exchangeWithClass:(Class)cls
                 originSEL:(SEL)oriSEL originMethod:(Method)oriMethod
                swizzleSEL:(SEL)swiSEL swizzleMethod:(Method)swiMethod
                     force:(BOOL)isForce
                      flag:(NSString*)flag
{
    if (!cls) {
        NSLog(@"swizzling: ❌ Class can't be nil.");
        //NSAssert(NO, @"swizzling: ❌ Class can't be nil : %s", __func__);
        return;
    }
    if (!oriSEL) {
        NSLog(@"swizzling: ❌ origin SEL can't be nil.");
        return;
    }
    if (!swiSEL) {
        NSLog(@"swizzling: ❌ swizzle SEL can't be nil.");
        return;
    }
    
    
    NSString * oriDesc = [NSString stringWithFormat:@"%@[%@ %@]", flag, NSStringFromClass(cls), NSStringFromSelector(oriSEL)];
    NSString * swiDesc = [NSString stringWithFormat:@"%@[%@ %@]", flag, NSStringFromClass(cls), NSStringFromSelector(swiSEL)];
    
    if (!oriMethod && !swiMethod)
    {
        NSLog(@"swizzling: ❌ 2个方法都不存在,无法交换: %@, %@", oriDesc, swiDesc);
        return;
    }
    else if (oriMethod && !swiMethod)
    {
        if (!isForce) {
            NSLog(@"swizzling: %@ 不存在, 没有进行交换", swiDesc);
            return;
        }
        
        class_addMethod(cls, swiSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        method_setImplementation(oriMethod, imp_implementationWithBlock(^(id self, SEL _cmd) {
            NSLog(@"swizzling: %@ 不存在. 这是默认空实现", swiDesc);
        }));
        return;
    }
    else if (!oriMethod && swiMethod)
    {
        if (!isForce) {
            NSLog(@"swizzling: %@ 不存在, 没有进行交换", oriDesc);
            return;
        }
        
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd) {
            NSLog(@"swizzling: %@ 不存在. 这是默认空实现", oriDesc);
        }));
        return;
    }
    
    // class_addMethod will add an override of a superclass's implementation, but will not replace an existing implementation in this class. To change an existing implementation, use method_setImplementation.
    // return YES if the method was added successfully, otherwise NO (for example, the class already contains a method with that name).
    // SEL 与 IMP 一一对应, 多个 SEL 可以对应同一个 IMP.
    BOOL success = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    
    if (success) {
        NSLog(@"swizzling: class %@ add SEL:%@ to IMP:%@", NSStringFromClass(cls), NSStringFromSelector(oriSEL), NSStringFromSelector(swiSEL));
        
        // cls replace swiSEL to oriIMP
        class_replaceMethod(cls, swiSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));

        NSLog(@"swizzling: class %@ replace SEL:%@ to IMP:%@", NSStringFromClass(cls), NSStringFromSelector(swiSEL), NSStringFromSelector(oriSEL));
        
    } else {
        
        method_exchangeImplementations(oriMethod, swiMethod);
        
        NSLog(@"swizzling: class %@ exchange %@ and %@", NSStringFromClass(cls), NSStringFromSelector(oriSEL), NSStringFromSelector(swiSEL));
    }
    
}

@end
