//
//  GFTradeDao.m
//  GFTrademark
//
//  Created by ios－梁家安 on 16/8/17.
//  Copyright © 2016年 gf. All rights reserved.
//
#import "GFTradeDao.h"

//#import "GFCardVo.h"
//#import "GFCardOrderVo.h"

@implementation GFTradeDao


/**
 *  获取使用日志列表
 *
 *  参数看文档
 */
+ (void)ID:(NSString *)ID
                     block:(void(^)(NSMutableArray *numberVo,NSError *error))block  {
    
    NSMutableArray *dataVo = [[NSMutableArray alloc]init];

    //[dataArray addObject:@""];

    NSMutableArray *dataArray = [NSMutableArray new]; //用来盛放数据的value

    NSDictionary *dic = @{@"addTime":@"2019",@"equipmentCode":@"主设备",@"describe":@"登录"};
    NSDictionary *dic1 = @{@"addTime":@"2018",@"equipmentCode":@"副设备",@"describe":@"注销"};
    NSDictionary *dic2 = @{@"addTime":@"2017",@"equipmentCode":@"主设备",@"describe":@"查询"};

    [dataArray addObjectsFromArray:@[dic,dic1,dic2]];

    
    for (NSDictionary *info in dataArray) {

        GFTradeVo *vo = [GFTradeVo new];

        vo.addTime = info[@"addTime"];
        vo.equipmentCode = info[@"equipmentCode"];
        vo.describe = info[@"describe"];

        [dataVo addObject:vo];

        //NSLog(@"%@",info);

    }
    block(dataVo,nil);

}


@end
