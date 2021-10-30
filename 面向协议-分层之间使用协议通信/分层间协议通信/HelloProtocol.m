#import "HelloProtocol.h"
#import "FirstModule.h"

@implementation HelloProtocol

- (void)sayHello:(NSString*)name { 
    FirstModule *fm = [FirstModule new];
    [fm helloWithName:name];
}

@end
