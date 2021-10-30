#import <Foundation/Foundation.h>

// 定义协议
@protocol HelloProtocol <NSObject>
@required
- (void)sayHello:(NSString*)name;
@end


// 添加协议默认实现
@interface HelloProtocol : NSObject<HelloProtocol>

@end
