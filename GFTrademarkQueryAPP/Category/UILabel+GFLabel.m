//
//  UILabel+GFLabel.m
//  testTryCatch
//
//  Created by chuanglong02 on 16/7/15.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import "UILabel+GFLabel.h"

@implementation UILabel (GFLabel)
+(UILabel *)GFLabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label =[[UILabel alloc]init];
    label.textAlignment = textAlignment;
    label.text = text;
    label.backgroundColor = backgroundColor;
    label.frame= frame;
    label.font = font;
    label.textColor = textColor;
    return label;
}
+(UILabel *)GFLabelWithTextNoFrame:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label =[[UILabel alloc]init];
    label.textAlignment = textAlignment;
    label.text = text;
    label.backgroundColor = backgroundColor;
    label.font = font;
    label.textColor = textColor;
    return label;
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
//label标签🏷中文本向左对齐
- (void) textLeftTopAlign
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    self.frame = dateFrame;
}
//label标签🏷中文本向右对齐
- (void) textRightTopAlign
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    self.frame = dateFrame;
}
@end
