//
//  CQPointHUD.m
//  弹窗哈哈哈
//
//  Created by 蔡强 on 2017/6/7.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "CQHUD.h"
#import <Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "UIColor+Util.h"
//#import <UIImageView+WebCache.h>
//#import "CQLoadingView.h"

@implementation CQHUD
#pragma mark - 带网络图片与block回调的弹窗
/**
 带网络图片与block回调的弹窗

 @param imageURL 图片URL
 @param buttonClickedBlock 兑换按钮点击时的回调
 */
+ (void)showAlertWithImageURL:(NSString *)imageURL ButtonClickedBlock:(void (^)(void))buttonClickedBlock {
    // 先获取网络图片
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    //[goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    // 获取图片成功后再搭建UI
    [goodsImageView setImage:[UIImage imageNamed:imageURL]];
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //整体的布局view
    UIView *totalView = [[UIView alloc]init];
    [bgView addSubview:totalView];
    [totalView setBackgroundColor:[UIColor whiteColor]];
    [totalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(-20);
        make.left.mas_equalTo(bgView.mas_left).with.offset(20);
        make.right.mas_equalTo(bgView.mas_right).with.offset(-20);
        make.height.mas_equalTo(totalView.mas_width);
        //make.width.mas_equalTo(200);
    }];
    //[bgView addSubview:totalView];
    
    
    
    
    //提示关注微信号的label
    UILabel *labelWX = [[UILabel alloc]init];
    [labelWX setText:@"关注【国方商标软件】微信公共号"];
    [labelWX setFont:[UIFont systemFontOfSize:14]];
    [totalView addSubview:labelWX];
    [labelWX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(totalView).with.mas_offset(6);
        make.top.mas_equalTo(totalView).with.mas_offset(20);
        //make.height.equalTo();
    }];
    //beforeLabelImage
    UIImageView *beforeLabelImage = [[UIImageView alloc]init];
    [totalView addSubview:beforeLabelImage];
    [beforeLabelImage setImage:[UIImage imageNamed:@"微信"]];
    [beforeLabelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(totalView).with.mas_offset(20);
        make.centerY.equalTo(labelWX);
        make.right.mas_equalTo(labelWX.mas_left).with.mas_offset(-3);
        //make.height.equalTo(labelWX);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    //微信号名称
    
    UILabel *nameWX = [[UILabel alloc]init];
    [totalView addSubview:nameWX];
    [nameWX setText:@"GFTM888"];
    [nameWX setTextColor:GFMainColor];
    [nameWX setFont:[UIFont systemFontOfSize:13]];
    [nameWX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalView);
        make.top.equalTo(labelWX.mas_bottom).offset(5);
    }];
    
    //提示语句
    UILabel *textLabel = [[UILabel alloc]init];
    [totalView addSubview:textLabel];
    [textLabel setText:@"获取众多最新的商标资讯，小编在这里等着你哟！"];
    [textLabel setTextColor:[UIColor grayColor]];
    [textLabel setFont:[UIFont systemFontOfSize:12]];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalView);
        make.top.equalTo(nameWX.mas_bottom).offset(5);
    }];
    // 微信二维码图片
    [totalView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(totalView);
        make.centerY.mas_equalTo(totalView).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    //提示关注label
    UILabel *attentLabel = [[UILabel alloc] init];
    [totalView addSubview:attentLabel];
    attentLabel.text = @"保存图片，打开微信扫一扫，从相册中选取二维码";
    attentLabel.textAlignment = NSTextAlignmentCenter;
    attentLabel.font = [UIFont systemFontOfSize:12];
    attentLabel.textColor = [UIColor grayColor];
    [attentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.centerX.mas_equalTo(totalView);
        make.top.mas_equalTo(goodsImageView.mas_bottom).mas_offset(8);
    }];
    
    //实现动画提醒
    UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_success"]];
    [totalView addSubview:signImageView];
    [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(attentLabel);
        make.left.mas_equalTo(attentLabel.mas_right).mas_offset(3);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    //提示领取免费软件使用权
    UILabel *scoreLabel = [[UILabel alloc] init];
    [totalView addSubview:scoreLabel];
    scoreLabel.textColor = [UIColor grayColor];
    scoreLabel.text = @"小主~快去关注领取免费软件使用权哟😝";
    scoreLabel.adjustsFontSizeToFitWidth = YES; // 避免尴尬情况
    scoreLabel.font = [UIFont systemFontOfSize:12];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(attentLabel.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(totalView);
        //make.left.right.mas_equalTo(goodsImageView);
    }];
    //划分双button的view
    UIView  *betweenButtonView = [[UIView alloc]init];
    [totalView addSubview:betweenButtonView];
    [betweenButtonView setBackgroundColor:[UIColor blueColor]];
    [betweenButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(totalView);
        make.bottom.mas_equalTo(totalView.mas_bottom).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(5,30));
    }];
    
    
    //复制公共号按钮
    UIButton *copyButton = [[UIButton alloc] init];
    [totalView addSubview:copyButton];
    copyButton.backgroundColor = GFMainColor;
    [copyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [copyButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [copyButton setTitle:@"复制公共号" forState:UIControlStateNormal];
    copyButton.layer.cornerRadius = 6;
    copyButton.layer.borderWidth = 1;
    copyButton.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    /*设计按钮样式及其回调block*/
//    copyButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
//    copyButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
    [[copyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //[self copyWXTextAction];
        
        UIPasteboard *appPasteBoard =  [UIPasteboard generalPasteboard];
        appPasteBoard.persistent = YES;
        NSString *pasteStr =@"GFTM888";
        [appPasteBoard setString:pasteStr];
        
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"完成复制",nil),nil] message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alertview show];
        
        //buttonClickedBlock(); // 回调block
        //[bgView removeFromSuperview];
    }];
    
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(totalView).with.mas_offset(10);
        make.right.mas_equalTo(betweenButtonView).with.mas_offset(-5);
        make.bottom.mas_equalTo(totalView.mas_bottom).mas_offset(-5);
        make.height.mas_equalTo(betweenButtonView);
    }];
    //[copyButton addTarget:self action:@selector(copyWXTextAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    // 保存图片按钮
    UIButton *saverButton = [[UIButton alloc] init];
    [totalView addSubview:saverButton];
    saverButton.backgroundColor = GFMainColor;
    [saverButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saverButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [saverButton setTitle:@"保存图片" forState:UIControlStateNormal];
    saverButton.layer.cornerRadius = 6;
    saverButton.layer.borderWidth = 1;
    saverButton.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    /*设计按钮样式及其回调block
//    saverButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
//    [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateNormal];
//    [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateHighlighted];
//    saverButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
    */
    [[saverButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        buttonClickedBlock(); // 回调block
        //[bgView removeFromSuperview];
    }];
    
    [saverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(betweenButtonView).with.mas_offset(5);
        make.right.mas_equalTo(totalView).with.mas_offset(-10);
        make.bottom.mas_equalTo(totalView.mas_bottom).mas_offset(-5);
        make.height.mas_equalTo(betweenButtonView);
    }];
    betweenButtonView.hidden = true;
    //[saverButton addTarget:self action:@selector(savePictureAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [totalView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(totalView).mas_offset(-2);
        make.top.mas_equalTo(totalView.mas_top).mas_offset(2);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}
//复制微信号文本
-(void)copyWXTextAction{
//    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    pboard.string = @"GFTM888";
//
    UIPasteboard *appPasteBoard =  [UIPasteboard generalPasteboard];
    appPasteBoard.persistent = YES;
    NSString *pasteStr =@"GFTM888";
    [appPasteBoard setString:pasteStr];
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"完成复制",nil),nil] message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
    [alertview show];
    //[SVProgressHUD showSuccessWithStatus:@"复制成功"];
}
//保存图片到本地
-(void)savePictureAction{
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
}
@end
