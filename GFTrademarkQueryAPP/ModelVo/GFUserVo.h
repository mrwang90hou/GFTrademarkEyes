//
//  GFUserVo.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/7/27.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBaseVo.h"

@interface GFUserVo : GFBaseVo

//当前卡是否过期 YES已过期，NO未过期
@property BOOL isguide;
//当前信息是否过期，或，是否登录了
@property BOOL isLogin;

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSNumber *loginID;
@property (nonatomic, strong) NSString *checkCode;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *contactTel;
@property (nonatomic, strong) NSString *contactMobile;
@property (nonatomic, strong) NSString *contactEmail;
//新增
@property (nonatomic, strong) NSNumber *checkMethod;
@property (nonatomic, strong) NSString *isMainDevice;
@property (nonatomic, strong) NSString *deviceRemark;               //设备备注
@property (nonatomic, strong) NSNumber *deviceCount;

@property (nonatomic, strong) NSNumber *cardType;
@property (nonatomic, strong) NSString *activeTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSNumber *validMethod;
@property (nonatomic, strong) NSNumber *remainCount;
@property (nonatomic, strong) NSNumber *equipmentCount;
@property (nonatomic, strong) NSNumber *attachedCardCount;


@end
