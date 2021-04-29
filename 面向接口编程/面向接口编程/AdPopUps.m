//
//  AdPopUps.m
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//

#import "AdPopUps.h"
#import "AdView.h"

@implementation AdPopUps

- (void)execute {
    AdView *adView = [[AdView alloc] init];
    adView.frame = CGRectMake(0, 0, 100, 100);
    [adView show];
}

@end


