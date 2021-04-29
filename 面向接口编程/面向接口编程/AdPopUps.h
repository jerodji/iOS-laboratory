//
//  AdPopUps.h
//  面向接口编程
//
//  Created by Jerod on 2021/4/18.
//

#import <Foundation/Foundation.h>
#import "Protocal.h"


@interface AdPopUps : NSObject <PopUpsProtocol>

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *content;

@end
