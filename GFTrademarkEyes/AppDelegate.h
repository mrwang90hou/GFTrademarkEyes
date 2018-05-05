//
//  AppDelegate.h
//  GFTrademarkEyes
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFSlideController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property UINavigationController *recognitionNavigation;
@property(nonatomic,strong)GFSlideController *gfSlideVc;
@end
