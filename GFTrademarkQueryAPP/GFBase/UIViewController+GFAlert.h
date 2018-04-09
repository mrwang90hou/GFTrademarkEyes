//
//  UIViewController+GFAlert.h
//  GFTrademark
//
//  Created by 王宁 on 2018/3/29.
//  Copyright © 2018年 王宁. All rights reserved.
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
