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
    
    
    
    
    
    
    
    
//
//    UITextView *textView = [[UITextView alloc]init];
//    [textView setText:@"\t佛山市国方商标服务有限公司成立于2003年，是国家认定的高新技术企业和双软企业，也是国家商标局备案的商标代理机构，是目前国内少有的同时从事商标专业软件研发和商标代理法律服务的企业。\n\t经过10多年的发展，本公司已成为一家拥有多名资深商标专家、商标代理人、软件工程师和项目管理专家的综合型商标服务机构。在商标专业软件研发领域，公司已建立了一个动态同步更新、数据完整准确的中国商标数据库，并以此数据库为基础，成功研发了20多款商标专业软件（其中有5款软件被认定为高新技术产品），处于国内领先水平，是目前国内拥有商标专业软件著作权最多的企业。在商标代理法律服务领域，公司不仅成功通过广东商标代理服务规范审核认定小组的审核，成为目前佛山地区首家也是唯一一家符合《广东省商标代理服务规范》的商标代理机构，而且“国方商标代理服务”还在2016年被省高新技术企业协会认定为高新技术服务，这是目前国内少有的。\n\t截至日前，公司累计服务客户数过万，服务过的客户遍布全国多个省份、包括港澳台及日本等地区。本公司不仅是软件行业协会理事单位、佛山市商标协会副会长单位，而且还得到了相关部门的认可——广东省工商局于2014年委托我司为广东商标品牌战略研究活动提供相关商标数据分析服务，佛山市工商局于2013年起委托我司为佛山地区商标预警工作提供支持服务。"];
//    [self.view addSubview:textView];
//    [textView setTextColor:[UIColor blackColor]];
//    [textView setFont:[UIFont systemFontOfSize:14.f]];
//    [textView setEditable:false];
//    [textView setSelectable:false];
//    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.view).with.offset(10);//左侧
//        make.trailing.equalTo(self.view).with.offset(-10);//右侧   -90
//        //make.top.equalTo(imageView.mas_bottom).with.offset(10);
//        make.top.equalTo(imageView.mas_bottom).offset(5);
//        make.bottom.equalTo(self.view.mas_bottom).offset(5);
//
//        make.height.equalTo([NSNumber numberWithFloat:(Device_Height)]);
//        //make.height.equalTo([NSNumber numberWithFloat:(Device_Width)]);
//    }];
}

@end

