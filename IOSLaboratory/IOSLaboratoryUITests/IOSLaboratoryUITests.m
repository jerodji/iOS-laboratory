//
//  IOSLaboratoryUITests.m
//  IOSLaboratoryUITests
//
//  Created by Jerod on 2021/4/29.
//

#import <XCTest/XCTest.h>

@interface IOSLaboratoryUITests : XCTestCase

@end

@implementation IOSLaboratoryUITests

- (void)setUp {
    // 设置代码在这里。在调用类中的每个测试方法之前调用此方法。

    // 在UI测试中，当失败发生时，通常最好立即停止。
    self.continueAfterFailure = NO;

    // 在UI测试中，重要的是在测试运行之前设置测试所需的初始状态，例如界面朝向。setUp方法是这样做的好地方。
}

- (void)tearDown {
    // 把拆卸代码放在这里。在调用类中的每个测试方法之后调用此方法。
}

- (void)testExample {
    // UI测试必须启动它们所测试的应用程序。
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // 使用记录开始编写UI测试。
    // 使用XCTAssert和相关函数来验证您的测试产生正确的结果。
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // 这度量了启动应用程序所需的时间。
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
