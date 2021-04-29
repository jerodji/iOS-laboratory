//
//  Protocal.h
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//


@protocol PopUpsProtocol <NSObject>

/// 活动类型（标识符）
@property(nonatomic, copy) NSString *type;
/// 跳转url
@property(nonatomic, copy) NSString *url;
/// 文字内容
@property(nonatomic, copy) NSString *content;

@required
/// 开启执行，在这个方法中展示出弹窗
- (void)execute;

@end



