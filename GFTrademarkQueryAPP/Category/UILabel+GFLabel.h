//
//  UILabel+GFLabel.h
//  testTryCatch
//
//  Created by chuanglong02 on 16/7/15.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (GFLabel)

-(void)sizeWithfont:(CGFloat)font color:(UIColor *)color TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text mark:(NSInteger)mark;

+(UILabel *)GFLabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;
+(UILabel *)GFLabelWithTextNoFrame:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

- (void) textLeftTopAlign;
- (void) textRightTopAlign;

@end
