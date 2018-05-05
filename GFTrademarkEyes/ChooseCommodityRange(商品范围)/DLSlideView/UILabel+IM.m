//
//  UILabel+IM.m
//  btb
//
//  Created by ios－梁家安 on 16/4/13.
//  Copyright © 2016年 shs. All rights reserved.
//

#import "UILabel+IM.h"

@implementation UILabel (IM)

+ (void)initialize
{
    [[UILabel appearance] setAdjustsFontSizeToFitWidth:YES];
    [[UILabel appearance] setNumberOfLines:0];
}

-(void)sizeWithfont:(CGFloat)font color:(UIColor *)color TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text mark:(NSInteger)mark
{
    //1无限缩小，适合段laber，0限制高度
    if (mark == 1)
    {
        [self setAdjustsFontSizeToFitWidth:YES];
        
    } else {
        
        self.numberOfLines = 0;
    }
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = color;
    self.textAlignment = TextAlignment;
    self.text = text;
    
}

-(void)backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text sizeWithfont:(CGFloat)font minimumWithfont:(CGFloat)minimumfont mark:(NSInteger)mark
{
    //1无限缩小，适合段laber，0限制高度
    if (mark == 1)
    {
        self.minimumScaleFactor = minimumfont;//默认值为0，为当前字体大小
        [self setAdjustsFontSizeToFitWidth:YES];
    } else {
        self.numberOfLines = 0;
    }
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = textColor;
    self.textAlignment = TextAlignment;
    self.text = text;
    self.backgroundColor = backgroundColor;
}

-(void)setWidth:(CGFloat)width widthColor:(UIColor*)color backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text sizeWithfont:(CGFloat)font mark:(NSInteger)mark
{
    //1无限缩小，适合段laber，0限制高度
    if (mark == 1)
    {
        [self setAdjustsFontSizeToFitWidth:YES];
    } else{
        self.numberOfLines = 0;
    }
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = textColor;
    self.textAlignment = TextAlignment;
    self.text = text;
    self.backgroundColor = backgroundColor;
    
}

-(void)setFWBString:(UILabel*)str String:(NSString*)rangstr color:(UIColor*)color
{
    NSRange range = [str.text rangeOfString:rangstr];
    NSMutableAttributedString *strFWB = [[NSMutableAttributedString alloc] initWithString:str.text];
    [strFWB addAttribute:NSForegroundColorAttributeName value:color range:range];
    str.attributedText = strFWB;
}

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}



@end
