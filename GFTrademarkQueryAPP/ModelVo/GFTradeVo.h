//
//  GFTradeVo.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/25.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBaseVo.h"

@interface GFTradeVo : GFBaseVo

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *inLog;
@property (nonatomic, strong) NSString *outLog;
@property (nonatomic, strong) NSString *allLog;

/**
 *  安的数据结构
 */
@property (nonatomic, strong) NSString *payInfo;//交易信息
@property (nonatomic, strong) NSNumber *payMoney;//支出或收入金额(单位:元,正数为收入,负数为 支出)
@property (nonatomic, strong) NSNumber *remainMoney;//账户余额(单位:元)
@property (nonatomic, strong) NSString *payTime;//交易时间,格式:年 月 日 时  分  秒

//用户的国方卡信息
@property (nonatomic, strong) NSNumber *mid;
@property (nonatomic, strong) NSNumber *cardID;
@property (nonatomic, strong) NSNumber *cardNum;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *cardValue;
@property (nonatomic, strong) NSString *validTime;
@property (nonatomic, strong) NSString *validTimeType;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *activeState;
@property (nonatomic, strong) NSString *activeTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *validMethod;
@property (nonatomic, strong) NSNumber *remainCount;
@property (nonatomic, strong) NSString *equipmentCount;
@property (nonatomic, strong) NSString *attachedCardCount;
@property (nonatomic, strong) NSString *orderID;

//操作日志
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *equipmentCode;
@property (nonatomic,strong) NSString *equipmentNumber;       //<mrwang90hou-2018.1.16.pm  新建>
@property (nonatomic, strong) NSString *describe;

//网上服务 - 事宜
@property (nonatomic, strong) NSNumber *onlineId;
@property (nonatomic, strong) NSNumber *onlineGrade;
@property (nonatomic, strong) NSString *onlineCode;
@property (nonatomic, strong) NSString *onlineName;

@end
