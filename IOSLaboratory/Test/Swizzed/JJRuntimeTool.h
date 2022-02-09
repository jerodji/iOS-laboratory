//
//  RuntimeTool.h
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import <Foundation/Foundation.h>

@interface JJRuntimeTool : NSObject

/// 交换实例方法.
/// 调用方法的地方建议用 dispatch_once 包裹, 防止多次交换.
/// 发生错误(比如方法不存在)后会使用默认空实现进行交换
/// @param cls 类型
/// @param oriSEL 原本的方法
/// @param swiSEL 交换的方法
+ (void)swizzlingInstanceMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL;

/// 交换实例方法.
/// 调用方法的地方建议用 dispatch_once 包裹, 防止多次交换.
/// swizzling method only, no affect to super class.
/// @param cls 类型
/// @param oriSEL 原本的方法
/// @param swiSEL 交换的方法
/// @param isForce 是否强制交换, 默认 NO; 如果 YES,发生错误(比如方法不存在)后会使用默认的空实现进行交换
+ (void)swizzlingInstanceMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL force:(BOOL)isForce;


/// 交换类方法.
/// 调用方法的地方建议用 dispatch_once 包裹, 防止多次交换.
/// 发生错误(比如方法不存在)后会使用默认空实现进行交换.
/// @param cls 类型
/// @param oriSEL 原本的方法
/// @param swiSEL 交换的方法
+ (void)swizzlingClassMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL;

/// 交换类方法.
/// 调用方法的地方建议用 dispatch_once 包裹, 防止多次交换.
/// @param cls 类型
/// @param oriSEL 原本的方法
/// @param swiSEL 交换的方法
/// @param isForce 是否强制交换, 默认 NO; 如果 YES,发生错误(比如方法不存在)后会使用默认的空实现进行交换
+ (void)swizzlingClassMethodWithClass:(Class)cls originSEL:(SEL)oriSEL swizzleSEL:(SEL)swiSEL force:(BOOL)isForce;

@end
