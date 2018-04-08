//
//  ShareController.m
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/3/26.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface ShareController()

@end

@implementation ShareController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"";
    //设置背景颜色:黄色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化控件
    [self initView];
    
}
-(void)initView{
    
}
@end
