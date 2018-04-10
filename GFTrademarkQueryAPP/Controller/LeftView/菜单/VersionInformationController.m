//
//  VersionInformationController.m
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/4/8.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VersionInformationController.h"
@interface VersionInformationController()

@end

@implementation VersionInformationController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"版本信息";
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化控件
    [self initView];
    
}
-(void)initView{
    UIImageView *imageView = [UIImageView new];
    [self.view addSubview:imageView];
    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo([NSNumber numberWithFloat:(Device_Height / 16 * 9)]);
    }];
    [imageView assignmentWithImageView:@"GF_Black" model:UIViewContentModeScaleAspectFill];
    
    //分隔线
    UIView *lineView = [[UIView alloc]init];
    [self.view addSubview:lineView];
    [lineView setBackgroundColor:[UIColor greenColor]];
    [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        //make.leading.equalTo(self.view).with.offset(8);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(Device_Height / 7 * 1);
        make.height.mas_equalTo([NSNumber numberWithFloat:(Device_Height/7*1)]);
        make.width.mas_equalTo(@2);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.center.mas_equalTo(self.view);
    }];
    

    ZWVerticalAlignLabel *info01 = [[ZWVerticalAlignLabel alloc]init];
    //info01.backgroundColor =[UIColor blueColor];
    [info01 setText:@"   版本信息：\n   客服电话：\n微信公共号："];
    [self.view addSubview:info01];
    info01.font = [UIFont fontWithName:@"Helvetica-Light" size:14.f];//PingFangSC、Helvetica、Arial,Helvetica宋体、楷体
    //[info01 textLeftTopAlign];
    //info01.textColor=[UIColor lightGrayColor];
    [info01 textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_right);
    }];
    [info01 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineView);
        make.right.equalTo(lineView).with.offset(-3);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(80);
    }];
    ZWVerticalAlignLabel *info02 = [[ZWVerticalAlignLabel alloc]init];
    [info02 setText:@"V1.0\n12306\nGFTM8888"];
    [self.view addSubview:info02];
    [info02 setLineBreakMode:NSLineBreakByCharWrapping];
    info02.font = [UIFont fontWithName:@"Helvetica-Light" size:14.f];//Helvetica、Arial,Helvetica宋体、楷体-Bold粗体
    //info02.textColor=[UIColor lightGrayColor];
    [info02 textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_left);
    }];
    [info02 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineView);
        make.left.equalTo(lineView).with.offset(3);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(80);
    }];
    [lineView setHidden:true];
    
    
    /*【技术支持】改为图片展示
    //技术支持companyInfo

    UIView *companyInfoView = [[UIView alloc]init];
    [companyInfoView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:companyInfoView];
    [companyInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-5);
    }];     UILabel *titleInfo = [[UILabel alloc]init];
    UILabel *companyInfo = [[UILabel alloc]init];
    [companyInfoView addSubview:titleInfo];
    [companyInfoView addSubview:companyInfo];
    titleInfo.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
    companyInfo.font =[UIFont fontWithName:@"Helvetica-Light" size:12.f];
    [titleInfo  setText:@"技术支持"];
    [companyInfo setText:@"国方商标服务有限公司\n国方商标软件有限公司"];
    [titleInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Device_Width/5);
        make.centerY.equalTo(companyInfoView);
    }];
    [companyInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleInfo.mas_right).with.offset(5);
        make.centerY.equalTo(companyInfoView);
    }];
    [companyInfoView setBackgroundColor:[UIColor whiteColor]];
    
    
    */

    UIImageView *newImageView = [[UIImageView alloc]init];
    [self.view addSubview:newImageView];
    //[newImageView setImage:[UIImage imageNamed:@"开发单位"]];
    [newImageView assignmentWithImageView:@"开发单位" model:UIViewContentModeScaleAspectFill];
    [newImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view);
        //make.height.mas_equalTo(Device_Height/9);
    }];
    
    
}

@end

