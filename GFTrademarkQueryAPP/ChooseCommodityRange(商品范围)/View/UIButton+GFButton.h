//
//  UIButton+GFButton.h
//  GFTrademark
//
//  Created by ios－梁家安 on 16/9/29.
//  Copyright © 2016年 gf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GFButton)

/**
 *  按钮边框设置
 *
 *  @param r
 *  @param g
 *  @param b
 *  @param alpha
 *  @param width
 */
-(void)setBorderR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha width:(CGFloat)width;

- (void)resizedImageWithOrdinaryName:(NSString *)Ordinaryname HighlightName:(NSString *)HighlightName;

-(void)setButtonTitleAndImage:(NSString*)Normal Highlighted:(NSString*)Highlighted title:(NSString*)title;

-(void)setButtonBackgroundImage:(NSString*)Normal title:(NSString*)title;

-(void)setTitleAndFontAndColor:(UIColor*)color Title:(NSString*)title font:(CGFloat)font;

-(void)setTitleColor:(UIColor*)color Title:(NSString*)title font:(CGFloat)font backgroundColor:(UIColor*)backgroundColor;

-(UIButton*)getBianKuangAndTitle:(NSString*)Title R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha width:(CGFloat)width;

-(void)setTitleAndFontAndNColor:(UIColor*)NColor HColor:(UIColor*)HColor Title:(NSString*)title font:(CGFloat)font;

@end
