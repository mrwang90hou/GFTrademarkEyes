//
//  GFBasicController.m
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFBasicController.h"

@interface GFBasicController () <UITextFieldDelegate>

@end

@implementation GFBasicController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    //self.extendedLayoutIncludesOpaqueBars = YES;    //扩展布局包括不透明条。
//    if (@available(iOS 11.0, *)) {
//
//    } else {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//        // 这部分使用到的过期api
//        self.automaticallyAdjustsScrollViewInsets = NO;
//#pragma clang diagnostic pop
//    }
    
    /**************************/
    [self setupNavigationBar];
    /**************************/
    
}
//点击空白处关闭
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/**************************/
/**
 *  设置导航栏样式
 */
- (void)setupNavigationBar {
    // 设置导航栏标题颜色，字体大小，背景不透明，背景颜色
    NSMutableDictionary *titleParams = [[NSMutableDictionary alloc] init];
    [titleParams setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [titleParams setObject:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
    [self.navigationController.navigationBar setTranslucent:NO];//设置为半透明状态
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
    //[self.navigationController.navigationBar setBarTintColor:GFMainColor];
    
    // 设置导航栏左侧图标
    if ([[self.navigationController viewControllers] count] <= 1) {
        
        //此方法，head头像显示异常
//        UIBarButtonItem *left_view_btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"head"] style:UIBarButtonItemStyleDone target:self action:@selector(openDrawer)];
//        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: left_view_btn,nil]];
//
        // 处于根ViewControllers，仅显示Logo
        UIButton *left_view_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [left_view_btn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
        [left_view_btn addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:left_view_btn]];
//        //隐藏
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        //隐藏背景色
//        [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    } else {
        // 处于上层的ViewControllers显示返回按钮
        UIButton *backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [backView addTarget:self action:@selector(popViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 返回Icon
        UIImageView *backIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fanhui"]];
        [backView addSubview:backIcon];
        [backIcon setContentMode:UIViewContentModeCenter];
        [backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 40));
            make.left.equalTo(backView);
            make.centerY.equalTo(backView);
        }];
        
        // Logo
        UIImageView *backLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backView addSubview:backLogo];
        [backLogo setImage:[UIImage imageNamed:@"head"]];
        [backLogo setContentMode:UIViewContentModeCenter];
        [backLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backView);
            make.centerY.equalTo(backView);
        }];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backView]];
        [self.navigationItem setHidesBackButton:YES];
        
//        //隐藏
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        //隐藏背景色
//        [self.navigationController.navigationBar setValue:@100 forKeyPath:@"backgroundView.alpha"];
    }
}

/**
 *  点击导航栏返回按钮
 *  @param button 按钮对象
 */
- (void)popViewAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];       //返回弹出式控制器（mrwang90hou-2017.11.16  pm）
}
/////////////////////*******未能够理解的部分*******//////////////////（mrwang90hou-2017.11.16  pm）
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {      //支持的界面方向（mrwang90hou-2017.11.16  pm）
    return UIInterfaceOrientationMaskPortrait;
}
/**************************/
-(void)backClick
{
    //返回到之前的视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
//
-(void)openDrawer{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.gfSlideVc openDrawer];
}
// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
