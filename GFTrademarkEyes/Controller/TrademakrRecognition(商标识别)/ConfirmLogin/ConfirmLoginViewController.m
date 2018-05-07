//
//  ConfirmLoginViewController.m
//  git_test02
//
//  Created by 王宁 on 2018/3/9.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "ConfirmLoginViewController.h"
//#import "SVProgressHUD.h"
@interface ConfirmLoginViewController ()

@end

@implementation ConfirmLoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
}
//关闭操作
- (IBAction)btn_close_action:(id)sender {
   
#pragma mark - 应该修改为回到主视图
    //返回到之前的视图控制器
    // [self dismissViewControllerAnimated:YES completion:nil];
    
    //    [self.navigationController popToRootViewControllerAnimated:NO];
    //    [self dismissViewControllerAnimated:NO completion:^{
    //        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //        ViewController *tab = (ViewController *)delegate.window.rootViewController;
    //        //self.window.rootViewController = ViewControler;
    //        // 3.显示窗口
    //        //tab.selectedIndex = 0;
    //
    //    }];
    //    第一行代码让B的视图变为透明（由于父视图变为透明，任何B的子视图都会透明）。这样的效果将是C的视图从A的视图上滑出。
    //
    //    第二行代码中连续获取了两次presentingViewController，其实就是A，不过这使得A视图控制器中不用添加任何代码，从而解决了耦合的问题。
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
//登录操作
- (IBAction)btn_login_action:(id)sender {
    //S1:跳转输入验证码页面
    
    
    //S2:验证身份🆔是否正确✔️
    
    
    
    //S3:验证时间是否超时⏰
    NSString *str = @"wangning";
    //BOOL bl = self judgeOutTime:str;
    if ([self judgeOutTime:str]) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"登录超时⏰！" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        //[SVProgressHUD showSuccessWithStatus:@"登录超时！"];
    }else
    {
        
    }
    
    
}
//取消登录
- (IBAction)btn_logout_action:(id)sender {
  
#pragma mark - 应该修改为回到主视图
    //TODO:应该修改为回到主视图
    //FIXME:应该修改为回到主视图
    //返回到之前的视图控制器
    //[self dismissViewControllerAnimated:YES completion:nil];
    //    第一行代码让B的视图变为透明（由于父视图变为透明，任何B的子视图都会透明）。这样的效果将是C的视图从A的视图上滑出。
    //
    //    第二行代码中连续获取了两次presentingViewController，其实就是A，不过这使得A视图控制器中不用添加任何代码，从而解决了耦合的问题。
    
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
//判断是否超时
-(bool)judgeOutTime:(NSString *)str{        //str为传递进来的时间
    
    return true;
}

@end
