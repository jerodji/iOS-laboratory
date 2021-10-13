//
//  main.m
//  copy
//
//  Created by DZ0400645 on 2021/10/12.
//  Copyright © 2021 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject
@property (nonatomic, copy) NSString * name;
@end
@implementation Person
- (void)log {
    NSLog(@"name : %p - %p - %@", &_name, _name, _name);
}
@end


int main(int argc, const char * argv[]) {
    
    
    NSString * str = @"aaaaaaa";
    NSLog(@"1 str : %p - %p - %@", &str, str, str);
    Person *p = [Person new];
    p.name = str;
//    str = [str stringByAppendingString:@"bbbb"];
    str = @"bbbb";
    [p log];
    NSLog(@"2 str : %p - %p - %@", &str, str, str);
    /*
     1 str : 0x7ffeefbff448 - 0x100004038 - aaaaaaa
     name : 0x1007090e8 - 0x100004038 - aaaaaaa
     2 str : 0x7ffeefbff448 - 0x100004078 - bbbb
     */
    
    /*
     给name赋值NSString类型，用copy或者strong一样。
     但是如果赋值MutableString类型，情况就不一样了，只有copy能保证正确，见如下示例
     */
    
//    NSMutableString * str = [[NSMutableString alloc] initWithString:@"aaaaaaa"];
//    NSLog(@"1 str : %p - %@", str, str);
//    Person *p = [Person new];
//    p.name = str;
//    [str appendString:@"bbbbb"];
//    NSLog(@"name : %p - %@", p.name, p.name);
//    NSLog(@"2 str : %p - %@", str, str);
    /*
     // strong name
     1 str : 0x1050b6400 - aaaaaaa
     name : 0x1050b6400 - aaaaaaabbbbb   -> 值被改变
     2 str : 0x1050b6400 - aaaaaaabbbbb
     // copy name
     1 str : 0x100620080 - aaaaaaa
     name : 0xdfe92a4ecceb163b - aaaaaaa  -> 深拷贝，不会改变
     2 str : 0x100620080 - aaaaaaabbbbb
     */
    
    return 0;
}
