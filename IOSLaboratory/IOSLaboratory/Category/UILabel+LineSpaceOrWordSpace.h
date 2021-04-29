//
//  UILabel+LineSpaceOrWordSpace.h
//  AFN
//
//  Created by Jerod on 2021/2/2.
//  Copyright © 2021 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpaceOrWordSpace)

- (void)setLineSpace:(CGFloat)space;

- (void)setWordSpace:(CGFloat)space;

- (void)setLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

@end


//    UILabel *lab = [UILabel new];
//    lab.text = @"在实际开发中，Label的默认行间距大小一般都是满足不了UI设计师设计的行间距大小的。于是乎，就需要我们开发人员手动调整Label的行间距大小。然而，UILabel并没有提供直接修改行间距大小的属性,但是我们可以用Label的attributedText属性来设置. 在实际开发中，Label的默认行间距大小一般都是满足不了UI设计师设计的行间距大小的。于是乎，就需要我们开发人员手动调整Label的行间距大小。然而，UILabel并没有提供直接修改行间距大小的属性,但是我们可以用Label的attributedText属性来设置";
//    lab.textColor = UIColor.blackColor;
//    lab.backgroundColor = [UIColor.systemPinkColor colorWithAlphaComponent:0.4];
//    lab.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, CGFLOAT_MIN);
//    lab.numberOfLines = 0;
////    [lab setLineSpace:3];
////    [lab setWordSpace:5];
//    [lab setLineSpace:3 wordSpace:0];
//    [self.view addSubview:lab];
