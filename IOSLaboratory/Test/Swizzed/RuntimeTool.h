//
//  RuntimeTool.h
//  IOSLaboratory
//
//  Created by Jerod on 2021/6/23.
//

#import <Foundation/Foundation.h>



@interface RuntimeTool : NSObject


/// exchange super's imp also, it's not you expected.
+ (void)simple_methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL;


/// swizzling cls only, no affect to super class.
+ (void)methodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swiSEL:(SEL)swiSEL;

@end

