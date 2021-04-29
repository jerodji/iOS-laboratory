//
//  MSPopUpsTask.m
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//

#import "MSPopUpsTask.h"

@implementation MSPopUpsTask

- (instancetype)initWithPriority:(PopUpsTaskPriority)priority
                        activity:(id<PopUpsProtocol>)activity
                      identifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.activity = activity;
        self.priority = priority;
    }
    return self;
}

- (void)handle {
    if ([_activity respondsToSelector:@selector(execute)]) {
        [_activity execute];
    }
}

@end
