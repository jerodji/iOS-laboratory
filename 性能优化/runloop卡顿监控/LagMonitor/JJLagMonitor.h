//
//  JJLagMonitor.h
//  runloop卡顿监控
//
//  Created by Jerod on 2021/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJLagMonitor : NSObject
//@property (nonatomic, copy, class) NSString * version;
+ (instancetype)shared;

- (void)beginMonitor;

- (void)endMonitor;

@end

NS_ASSUME_NONNULL_END
