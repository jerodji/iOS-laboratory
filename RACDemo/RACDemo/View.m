//
//  View.m
//  RACDemo
//
//  Created by Jerod on 2020/8/13.
//  Copyright © 2020 Jerod. All rights reserved.
//

#import "View.h"

@implementation View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        l.text = self.name;
        [self addSubview:l];
        
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"btn" forState:UIControlStateNormal];
        _btn.frame = CGRectMake(10, 50, 100, 40);
        [self addSubview:_btn];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btnClick:(UIButton*)button {
    [self clickAction:@">> btn click params <<"];
}

- (void)clickAction:(NSString*)arg {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
