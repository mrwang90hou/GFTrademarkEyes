//
//  ConnectToUsController.m
//  GFTrademarkEyes
//
//  Created by 王宁 on 2018/3/26.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectToUsController.h"
@interface ConnectToUsController()

@end

@implementation ConnectToUsController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"联系我们";
    //设置背景颜色:黄色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化控件
    [self initView];
    
}
-(void)initView{
    
    UIImageView *imageView = [UIImageView new];
    [self.view addSubview:imageView];
    [imageView assignmentWithImageView:@"雅庭国际广场.jpg" model:UIViewContentModeScaleAspectFill];
    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo([NSNumber numberWithFloat:(Device_Height / 10 * 4)]);
    }];
    
    UITextView *textView = [[UITextView alloc]init];
    [textView setText:@"公司名称：佛山市国方商标服务有限公司\n佛山市国方商标软件有限公司\n公司地址：广东省佛山市禅城区\n汾江南路18号雅庭国际广场一座1305室\n邮政编码：528000\n服务热线：0757-6688 0082\n\t\t    0757-6688 0100\n传真号码：0757-6660 9230\n服务监督：0757-6663 3662\n微信公共平台：国方商标软件"];
    [self.view addSubview:textView];
    [textView setTextColor:[UIColor blackColor]];
    [textView setFont:[UIFont systemFontOfSize:14.f]];
    [textView setEditable:false];
    [textView setSelectable:false];
    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(2);//左侧
        //make.right.mas_equalTo(self.view).with.offset(-80);//右侧   -90
        //make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(2);
        //make.bottom.mas_equalTo(self.view.mas_bottom).offset(2);
        make.width.mas_equalTo(Device_Width/3*2);
        make.height.mas_equalTo([NSNumber numberWithFloat:(Device_Height/10 * 6)]);
        //make.height.equalTo([NSNumber numberWithFloat:(Device_Width)]);
    }];
    UIImageView *wechatImage = [[UIImageView alloc]init];
    [self.view addSubview:wechatImage];
    [wechatImage assignmentWithImageView:@"微信公共号二维码.png" model:UIViewContentModeScaleAspectFill];
    [wechatImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textView.mas_right).with.offset(0);//左侧
        //make.right.mas_equalTo(self.view).with.offset(-10);//右侧
        //make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(50);
        //make.bottom.mas_equalTo(self.view.mas_bottom).offset(5);
        make.height.equalTo([NSNumber numberWithFloat:(Device_Height/5*1)]);
        make.width.mas_equalTo(Device_Width/3*1);
        //make.height.equalTo([NSNumber numberWithFloat:(Device_Width)]);
    }];
}
@end

