//
//  IOSLaboratoryTests.m
//  IOSLaboratoryTests
//
//  Created by Jerod on 2021/4/29.
//

#import <XCTest/XCTest.h>

#import "DispatchTest.h"
#import "OptionTest.h"
#import "ThreadLock.h"

@interface IOSLaboratoryTests : XCTestCase

@end

@implementation IOSLaboratoryTests

- (void)setUp {
    // 把设置代码放在这里。在调用类中的每个测试方法之前调用此方法。
}

- (void)tearDown {
    // 把拆卸代码放在这里。在调用类中的每个测试方法之后调用此方法。
}

- (void)testExample {
    // 这是一个功能测试用例。
    // 使用XCTAssert和相关函数来验证您的测试产生正确的结果。
}

- (void)testPerformanceExample {
    // 这是一个性能测试用例的例子。
    [self measureBlock:^{
        // 把你想要测量时间的代码放在这里。
    }];
}

- (void)test_dispatch {
    printf("----------------------------------\n");
    [DispatchTest begin];
}

- (void)test_option {
    printf("----------------------------------\n");
    [OptionTest begin];
}


- (void)test_lock {
    printf("\n");
//    [ThreadLock begin];
    [ThreadLock condition];
}





@end
