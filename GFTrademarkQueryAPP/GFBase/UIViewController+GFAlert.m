//
//  UIViewController+GFAlert.m
//  GFTrademark
//
//  Created by 梁梓龙 on 16/3/7.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "UIViewController+GFAlert.h"

@implementation UIViewController (GFAlert)

/** 显示一个AlertView，默认只包含一个取消按钮
 @param title alertView的标题
 @param message alertView的message
 @param cancelButtonTitle 取消按钮的标题
 
 @return 如果系统版本小于8.0，则会返回一个UIAlertView；否则返回一个UIAlertController
 */
- (id)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle {
    
    //判断当前系统版本
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (systemVersion < 8.0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        
        [alertView show];
        
        return alertView;
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return alertController;
        
    }
    
}

- (MBProgressHUD *)showLoadingHudWithTitle:(NSString *)title subtitle:(NSString *)subtitle onView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.removeFromSuperViewOnHide = YES;
    //因前期代码问题，所以这里统一处理：标题 温馨提示，后期代码维护，把外面 传值 来的title 以 nil值传进来。
    hud.labelText =  @"all_dialog_title";
    if (subtitle) {
        hud.detailsLabelText = subtitle;
    }
    
    return hud;
}

- (MBProgressHUD *)showNoticeHudWithTitle:(NSString *)title subtitle:(NSString *)subtitle onView:(UIView *)view inDuration:(NSTimeInterval)duration {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //因前期代码问题，所以这里统一处理：标题 温馨提示，后期代码维护，把外面 传值 来的title 以 nil值传进来。
    hud.labelText =  @"温馨提示";
    if (subtitle) {
        hud.detailsLabelText = subtitle;
    }
    hud.mode = MBProgressHUDModeText;
    
    [hud hide:YES afterDelay:duration];
    
    return hud;
}

- (CGSize)sizeWithString:(NSString*)str font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height
{
    CGSize size = CGSizeMake(width ,height);
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize nameSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return nameSize;
}

@end
