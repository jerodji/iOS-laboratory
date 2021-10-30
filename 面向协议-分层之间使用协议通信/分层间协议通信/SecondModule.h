#import <Foundation/Foundation.h>

@interface SecondModule : NSObject
//定义对外提供的接口/服务
- (instancetype)initWithName:(NSString*)name;
- (void)hello;
@end
