//
//  MSPopUpsTask.h
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//

#import <Foundation/Foundation.h>
#import "Protocal.h"

typedef NS_ENUM(NSUInteger, PopUpsTaskPriority) {
    PopUpsTaskPriorityLow,        //低
    PopUpsTaskPriorityDefault,    //默认
    PopUpsTaskPriorityHigh,       //高
};

@interface MSPopUpsTask : NSObject

//任务的唯一标识符
@property(nonatomic, copy) NSString *identifier;

//优先级
@property(nonatomic, assign) PopUpsTaskPriority priority;

//任务对应的活动
@property(nonatomic, strong) id<PopUpsProtocol> activity;

//初始化方法
- (instancetype)initWithPriority:(PopUpsTaskPriority)priority
                        activity:(id<PopUpsProtocol>)activity
                      identifier:(NSString *)identifier;

//执行任务
- (void)handle;


@end


