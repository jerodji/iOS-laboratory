//
//  ViewModel.h
//  RACDemo
//
//  Created by Jerod on 2020/8/13.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

@property (nonatomic, strong) Model *model;

@end

NS_ASSUME_NONNULL_END
