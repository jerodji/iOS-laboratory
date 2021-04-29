//
//  MKView.m
//  self引用
//
//  Created by Jerod on 2020/8/17.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import "MKView.h"

@implementation MKView

- (void)excuteBlock:(void(^)(BOOL bk))block {
    NSLog(@"111 MKView excuteBlock");
}



@end
