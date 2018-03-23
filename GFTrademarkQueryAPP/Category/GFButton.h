//
//  GFButton.h
//  ButtonBlock
//
//  Created by chuanglong02 on 16/8/4.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  Font(f) [UIFont systemFontOfSize:(f)]

typedef void (^ButtonBlock)(UIButton *button);

@interface GFButton : UIButton
@property(nonatomic,copy)ButtonBlock block;
@property(nonatomic,assign)NSInteger buttonID;

@property(nonatomic,assign)CGSize enlargeSize;

-(void)addClickBlock:(ButtonBlock)block;

+(GFButton *)GFButtonWithTitle:(NSString *)title  titleFont:(UIFont *)titleLabelFont Image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleLabelColor frame:(CGRect)frame;

+(GFButton *)GFButtonNoFrameWithTitle:(NSString *)title  titleFont:(UIFont *)titleLabelFont Image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleLabelColor;
@end
