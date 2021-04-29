//
//  MKView.h
//  self引用
//
//  Created by Jerod on 2020/8/17.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MKView : UIView

- (void)excuteBlock:(void(^)(BOOL bk))block;

@end


