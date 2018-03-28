//
//  UIBarButtonItem+GFNavigation.m
//  GFTrademark
//
//  Created by ios－梁家安 on 16/9/29.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "UIBarButtonItem+GFNavigation.h"

@implementation UIBarButtonItem (GFNavigation)

/**
 *  导航栏按钮设置
 *
 *  @param string 按钮名字
 */
-(UIBarButtonItem*)setButton:(NSString*)string controller:(UIViewController*)controller response:(SEL)response
{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 5, 60, 38);
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitle:string forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
//    [button setBorderR:134 G:211 B:250 alpha:0.5 width:1.0];
//    [button.layer setMasksToBounds:YES];
//    [button.layer setCornerRadius:5];
    
    [button addTarget:controller action:response forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* Item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return Item;
}

@end
