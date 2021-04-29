//
//  View.h
//  RACDemo
//
//  Created by Jerod on 2020/8/13.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface View : UIView

@property (nonatomic, copy) NSString *name;

- (void)changeAge:(int)age;

@property (nonatomic, strong) UIButton *btn;
- (void)clickAction:(NSString*)arg;

@end

NS_ASSUME_NONNULL_END
