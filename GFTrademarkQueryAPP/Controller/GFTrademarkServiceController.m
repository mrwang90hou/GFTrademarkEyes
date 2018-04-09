//
//  GFTrademarkServiceController.m
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFTrademarkServiceController.h"
#import "GFControlRootController.h"
@interface GFTrademarkServiceController ()

@end

@implementation GFTrademarkServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商标服务";
    [self setupView];
    //self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage GF_imageWithOriginalName:@"head"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
}


/**
 *  初始化界面
 */
- (void)setupView {
    
    // 设置背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 选择网上服务方式背景
    UIView *wayBg = [[UIView alloc] init];
    [self.view addSubview:wayBg];
    [wayBg setBackgroundColor:[UIColor whiteColor]];
    [wayBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    // 蓝色Logo
    UIView *wayLogo = [[UIView alloc] init];
    [wayBg addSubview:wayLogo];
    [wayLogo setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    [wayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(4);
        make.left.equalTo(wayBg).with.offset(10);
        make.centerY.equalTo(wayBg);
    }];
    
    // 查询方式文字提示
    UILabel *wayLabel = [[UILabel alloc] init];
    [wayBg addSubview:wayLabel];
    [wayLabel setText:@"请选择商标服务方式"];
    [wayLabel setFont:[UIFont systemFontOfSize:16]];
    [wayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wayLogo.mas_right).with.offset(10);
        make.centerY.equalTo(wayBg);
    }];
    
    // 分割线
    UIView *wayLine = [[UIView alloc] init];
    [wayBg addSubview:wayLine];
    [wayLine setBackgroundColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1]];
    [wayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(wayBg);
        make.right.equalTo(wayBg);
        make.bottom.equalTo(wayBg);
    }];
    
    //    // 按钮 商标注册网上申请
    //    GFButton *applyBtn = [[GFButton alloc] init];
    //    [self.view addSubview:applyBtn];
    //    [applyBtn setBackgroundImage:[UIImage imageNamed:@"ic_blue bow_normal"] forState:UIControlStateNormal];
    //    [applyBtn setBackgroundImage:[UIImage imageNamed:@"ic_blue bow_pressed"] forState:UIControlStateHighlighted];
    //    [applyBtn addTarget:self action:@selector(clickTrademarkApply) forControlEvents:UIControlEventTouchUpInside];
    //    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(45);
    //        make.left.equalTo(self.view).with.offset(10);
    //        make.right.equalTo(self.view).with.offset(-10);
    //        make.top.equalTo(wayLine).with.offset(15);
    //    }];
    //
    //    // 按钮文字
    //    UILabel *applyLabel = [[UILabel alloc] init];
    //    [self.view addSubview:applyLabel];
    //    [applyLabel setText:NSNewLocalizedString(@"web_service_apply", nil)];
    //    [applyLabel setFont:[UIFont systemFontOfSize:16]];
    //    [applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(applyBtn).with.offset(15);
    //        make.centerY.equalTo(applyBtn);
    //    }];
    //
    //    // 按钮LOGO
    //    UIImageView *applyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_register"]];
    //    [self.view addSubview:applyImage];
    //    [applyImage mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.mas_equalTo(25);
    //        make.height.mas_equalTo(25);
    //        make.right.equalTo(applyLabel.mas_left).with.offset(-5);
    //        make.centerY.equalTo(applyLabel);
    //    }];
    
    // 按钮 商标注册网上申请
    GFButton *onlineBtn = [[GFButton alloc] init];
    [self.view addSubview:onlineBtn];
    [onlineBtn setBackgroundImage:[UIImage imageNamed:@"ic_blue bow_normal"] forState:UIControlStateNormal];
    [onlineBtn setBackgroundImage:[UIImage imageNamed:@"ic_blue bow_pressed"] forState:UIControlStateHighlighted];
    [onlineBtn addTarget:self action:@selector(clickTrademarkOnline) forControlEvents:UIControlEventTouchUpInside];
    [onlineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.height.mas_equalTo(45);
        //        make.left.equalTo(self.view).with.offset(10);
        //        make.right.equalTo(self.view).with.offset(-10);
        //        make.top.equalTo(applyBtn.mas_bottom).with.offset(15);
        make.height.mas_equalTo(45);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.top.equalTo(wayLine).with.offset(15);
    }];
    onlineBtn.layer.masksToBounds = YES;
    onlineBtn.layer.cornerRadius = 4;
    onlineBtn.layer.borderWidth = 1;
    onlineBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    
    // 按钮文字
    UILabel *onlineLabel = [[UILabel alloc] init];
    [self.view addSubview:onlineLabel];
    [onlineLabel setText:@"商标事宜在线委托"];
    [onlineLabel setFont:[UIFont systemFontOfSize:16]];
    [onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(onlineBtn).with.offset(15);
        make.centerY.equalTo(onlineBtn);
    }];
    
    // 按钮LOGO
    UIImageView *onlineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_entrust"]];
    [self.view addSubview:onlineImage];
    [onlineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
        make.right.equalTo(onlineLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(onlineLabel);
    }];
    
    // 宣传图
    UIImageView *ad = [[UIImageView alloc] init];
    [self.view addSubview:ad];
    [ad setBackgroundColor:[UIColor whiteColor]];
    [ad assignmentWithImageView:@"bj_approvde" model:UIViewContentModeScaleAspectFit];
    [ad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width / 16 * 9);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark ===== 事件响应 =====

/**
 *  点击 商标注册网上申请
 */
- (void)clickTrademarkApply {
    NSLog(@"clickTrademarkApply");
}

/**
 *  点击 商标事宜在线委托
 */
- (void)clickTrademarkOnline {
    NSLog(@"clickTrademarkApply");
//    GFOnlineDelegateViewController *online = [[GFOnlineDelegateViewController alloc] init];
//    [online setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:online animated:YES];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:mrwang90hou@126.com"] options:@{} completionHandler:^(BOOL success) {
        NSLog(@"意见反馈");
    }];
}




-(void)openDrawer{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.gfSlideVc openDrawer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
