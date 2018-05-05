//
//  UILabel+IM.h
//  btb
//
//  Created by ios－梁家安 on 16/4/13.
//  Copyright © 2016年 shs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (IM)

-(void)sizeWithfont:(CGFloat)font color:(UIColor *)color TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text mark:(NSInteger)mark;

-(void)backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text sizeWithfont:(CGFloat)font minimumWithfont:(CGFloat)minimumfont mark:(NSInteger)mark;

-(void)setWidth:(CGFloat)width widthColor:(UIColor*)color backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text sizeWithfont:(CGFloat)font mark:(NSInteger)mark;

-(void)setFWBString:(UILabel*)str String:(NSString*)rangstr color:(UIColor*)color;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
