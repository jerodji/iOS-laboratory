#import "SecondModule.h"
#import "HelloProtocol.h"

@interface SecondModule ()
@property (nonatomic, strong) HelloProtocol *protocol;
@property (nonatomic, copy) NSString *name;
@end

@implementation SecondModule

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        _protocol = [HelloProtocol new];
        _name = name;
    }
    return self;
}

- (void)hello {
    [self.protocol sayHello:_name];
}

@end
