//
//  ViewController.m
//  demo
//
//  Created by Jerod on 2021/6/25.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: 点在三角形内
- (BOOL)inrect:(CGPoint)p inA:(CGPoint)a b:(CGPoint)b c:(CGPoint)c {
    BOOL sideA = [self inside:p inA:a b:b c:c];
    BOOL sideB = [self inside:p inA:a b:c c:b];
    BOOL sideC = [self inside:p inA:c b:a c:b];
    return sideA && sideB && sideC;
}

// 点与角的斜率 与 角上2个边的斜率对比
- (BOOL)inside:(CGPoint)p inA:(CGPoint)a b:(CGPoint)b c:(CGPoint)c {
    
    CGFloat L = ABS((a.x - b.x) / (a.y - b.y));
    CGFloat Q = ABS((p.x - b.x) / (p.y - b.y));
    CGFloat W = ABS((c.x - b.x) / (c.y - b.y));
    if (W < Q && Q < L) {
        return YES;
    } else {
        return NO;
    }
    
}

// MARK: 点在圆形内

- (BOOL)point:(CGPoint)point inCircleCenter:(CGPoint)center radii:(CGFloat)radii {
    // pow(a, b), 求幂, a的b次方
    // sqrt(c), 求c的平方根
    double distance = sqrt(pow(point.x - center.x, 2) + pow(point.y - center.y, 2));
    if (distance <= radii) {
        return YES;
    }
    return NO;
}



@end
