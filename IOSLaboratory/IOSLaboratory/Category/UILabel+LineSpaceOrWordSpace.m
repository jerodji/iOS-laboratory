//
//  UILabel+LineSpaceOrWordSpace.m
//  AFN
//
//  Created by Jerod on 2021/2/2.
//  Copyright © 2021 Jerod. All rights reserved.
//

#import "UILabel+LineSpaceOrWordSpace.h"

@implementation UILabel (LineSpaceOrWordSpace)

- (void)setLineSpace:(CGFloat)space {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    
    NSDictionary* dic = @{
        NSFontAttributeName: self.font,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    [attributedString addAttributes:dic range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)setWordSpace:(CGFloat)space {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary* dic = @{
        NSFontAttributeName: self.font,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    [attributedString addAttributes:dic range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)setLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSDictionary* dic = @{
        NSFontAttributeName: self.font,
        NSParagraphStyleAttributeName: paragraphStyle
    };
    [attributedString addAttributes:dic range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
}


@end
