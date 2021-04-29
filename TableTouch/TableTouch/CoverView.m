//
//  CoverView.m
//  TableTouch
//
//  Created by Jerod on 2020/10/18.
//

#import "CoverView.h"

@interface CoverView ()<UIGestureRecognizerDelegate>

@end
@implementation CoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _renderViews];
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
////    return self.tableView;
////    return self;
//    CGPoint p = [self convertPoint:point toView:self.tableView];
//    if ([self.tableView pointInside:p withEvent:event]) {
//        NSLog(@"yes");
//        UIView * v = [self.tableView hitTest:p withEvent:event];
//        return v;//UITableViewCellContentView
//
//    } else {
//        NSLog(@"no");
//        return self;
//    }
//    return nil;
//}

- (void)_renderViews {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.cancelsTouchesInView = NO;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 300, 375, 300);
    self.tableView.rowHeight = 150;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    [self addSubview:self.tableView];
}

// 手势事件拦截
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.tableView];
    if ([self.tableView pointInside:point withEvent:nil]) {
        return NO;
    } else {
        return YES;
    }
}

//// ios13.4
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveEvent:(UIEvent *)event {
//    CGPoint point = [gestureRecognizer locationInView:self.tableView];
//    if ([self.tableView pointInside:point withEvent:event]) {
//        return NO;
//    } else {
//        return YES;
//    }
//}

- (void)hide {
    NSLog(@"hide");
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.textLabel.text = @"测试";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了cell");
}


@end
