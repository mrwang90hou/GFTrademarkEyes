//
//  GFLeftBasicController.h
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/3/26.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KEY_LANGUAGE @"key_language" 
#define NSNewLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:KEY_LANGUAGE]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]



@interface GFLeftBasicController : UIViewController


/**
 *  设置导航栏样式
 */
- (void)setupNavigationBar;

/**
 *  点击导航栏返回按钮
 *  @param button 按钮对象
 */
- (void)popViewAction:(UIButton *)button;

//-(UINavigationController *)GF_NavController;

@end


