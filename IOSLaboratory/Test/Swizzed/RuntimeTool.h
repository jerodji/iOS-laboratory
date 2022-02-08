//
//  RuntimeTool.h
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import <Foundation/Foundation.h>



@interface RuntimeTool : NSObject


/// exchange super's imp also, it's not you expected.
//+ (void)simple_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL;


/// swizzling cls only, no affect to super class. but not the best
//+ (void)better_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL;


/// 方法交换.
/// 调用方法的地方建议用 dispatch_once 包裹, 防止多次交换.
/// swizzling method only, no affect to super class.
/// @param cls 类型
/// @param oriSEL 原本的方法
/// @param swiSEL 交换的方法
/// @param isForce 是否强制交换, 默认 NO; 如果 YES,发生错误(比如方法不存在)后会使用默认的空实现进行交换
+ (void)swizzlingInstanceMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL force:(BOOL)isForce;

+ (void)swizzlingClassMethodWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL;

@end


