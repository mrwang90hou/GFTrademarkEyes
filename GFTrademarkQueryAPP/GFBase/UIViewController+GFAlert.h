//
//  UIViewController+GFAlert.h
//  GFTrademark
//
//  Created by 梁梓龙 on 16/3/7.
//  Copyright © 2016年 gf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (GFAlert)

- (id)showAlertViewWithTitle:(NSString *)title
                     message:(NSString *)message
           cancelButtonTitle:(NSString *)cancelButtonTitle;

- (MBProgressHUD *)showLoadingHudWithTitle:(NSString *)title
                                  subtitle:(NSString *)subtitle
                                    onView:(UIView *)view;

- (MBProgressHUD *)showNoticeHudWithTitle:(NSString *)title
                                 subtitle:(NSString *)subtitle
                                   onView:(UIView *)view
                               inDuration:(NSTimeInterval)duration;

@end
