//
//  ViewController.m
//  Layer层级视觉
//
//  Created by Jerod on 2021/6/19.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *layer1;
@property (nonatomic, strong) CAShapeLayer *layer2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemPinkColor];
    
    self.layer1 = [CAShapeLayer layer];
    self.layer1.backgroundColor = [UIColor blueColor].CGColor;
    self.layer1.frame = CGRectMake(0, 100, 200, 200);
    self.layer1.contents = (__bridge id)[UIImage imageNamed:@"qyc.jpg"].CGImage;
    self.layer1.zPosition = 10;
    [self.view.layer addSublayer:self.layer1];
    
    self.layer2 = [CAShapeLayer layer];
    self.layer2.backgroundColor = [UIColor yellowColor].CGColor;
    self.layer2.frame = CGRectMake(100, 200, 200, 200);
    self.layer2.contents = (__bridge id)[UIImage imageNamed:@"img.jpeg"].CGImage;
    self.layer2.zPosition = 20;
    [self.view.layer addSublayer:self.layer2];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layer1.zPosition = 20;
    self.layer2.zPosition = 10;
}

@end
