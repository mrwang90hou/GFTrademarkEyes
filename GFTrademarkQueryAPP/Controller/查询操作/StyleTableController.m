//
//  StyleTableController.m
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/3/26.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StyleTableController.h"
@interface StyleTableController()

@end

@implementation StyleTableController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"基本信息";
    //设置背景颜色:黄色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化控件
    [self initView];
    
}
-(void)initView{
    UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [newView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:newView];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [btn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//    [newView addSubview:btn];
    
}
@end

