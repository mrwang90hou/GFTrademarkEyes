//
//  UIBarButtonItem+GFNavigation.h
//  GFTrademark
//
//  Created by ios－梁家安 on 16/9/29.
//  Copyright © 2016年 gf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GFNavigation)

/**
 *  导航栏按钮设置
 *
 *  @param string 按钮名字
 */
-(UIBarButtonItem*)setButton:(NSString*)string controller:(UIViewController*)controller response:(SEL)response;

@end
