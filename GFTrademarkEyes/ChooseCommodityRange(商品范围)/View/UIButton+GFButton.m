//
//  UIButton+GFButton.m
//  GFTrademark
//
//  Created by ios－梁家安 on 16/9/29.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "UIButton+GFButton.h"

@implementation UIButton (GFButton)

/**
 *  按钮边框设置
 *
 *  @param r
 *  @param g
 *  @param b
 *  @param alpha
 *  @param width
 */
-(void)setBorderR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha width:(CGFloat)width
{
    [self.layer setBorderWidth:width];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [self.layer setBorderColor: CGColorCreate(colorSpace,(CGFloat[]){ r/255.0, g/255.0, b/255.0, alpha })];
}


- (void)resizedImageWithOrdinaryName:(NSString *)Ordinaryname HighlightName:(NSString *)HighlightName
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (![HighlightName isEqualToString: @""])
    {
        [self setImage:[UIImage imageNamed:HighlightName] forState:UIControlStateHighlighted];
    }
    if (![Ordinaryname isEqualToString: @""])
    {
        [self setImage:[UIImage imageNamed:Ordinaryname] forState:UIControlStateNormal];
    }
    
    
}

-(void)setButtonTitleAndImage:(NSString*)Normal Highlighted:(NSString*)Highlighted title:(NSString*)title
{
    [self setImage:[UIImage imageNamed:Normal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:Highlighted] forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setButtonBackgroundImage:(NSString*)Normal title:(NSString*)title
{
    [self setBackgroundImage:[UIImage imageNamed:Normal] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setTitleAndFontAndColor:(UIColor*)color Title:(NSString*)title font:(CGFloat)font
{
    [self setTitle:title forState:UIControlStateNormal];
    //    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:font];
    self.titleLabel.font = [UIFont systemFontOfSize:font];
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setTitleColor:(UIColor*)color Title:(NSString*)title font:(CGFloat)font backgroundColor:(UIColor*)backgroundColor
{
    [self setTitle:title forState:UIControlStateNormal];
    self.backgroundColor = backgroundColor;
    self.titleLabel.font = [UIFont systemFontOfSize:font];
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(UIButton*)getBianKuangAndTitle:(NSString*)Title R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha width:(CGFloat)width
{
    UIButton *button = [UIButton new];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setBorderR:r G:g B:b alpha:alpha width:width];
    [button setTitle:Title forState:UIControlStateNormal];
    [button setTitleColor:LXColor(r, g, b, 1) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    return button;
}

-(void)setTitleAndFontAndNColor:(UIColor*)NColor HColor:(UIColor*)HColor Title:(NSString*)title font:(CGFloat)font
{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:font];
    [self setTitleColor:NColor forState:UIControlStateNormal];
    [self setTitleColor:HColor forState:UIControlStateSelected];
    
}


@end
