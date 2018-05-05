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

    NSDictionary *dic = @{@"range_first_id":@"21",@"range_second_id":@"2114",@"range_third_name":@"人造留窝鸡蛋",@"range_third_name_en":@"nest eggs, artificial"};
    NSDictionary *dic1 = @{@"range_first_id":@"05",@"range_second_id":@"0501",@"range_third_name":@"人工授精用精液",@"range_third_name_en":@"semen for artificial insemination"};
    NSDictionary *dic2 = @{@"range_first_id":@"01",@"range_second_id":@"0108",@"range_third_name":@"未加工人造树脂",@"range_third_name_en":@"artificial resins, unprocessed"};
    NSDictionary *dic3 = @{@"range_first_id":@"01",@"range_second_id":@"0109",@"range_third_name":@"粉末、液体或膏状的未加工人造树脂原材料",@"range_third_name_en":@""};

    [dataArray addObjectsFromArray:@[dic,dic1,dic2]];

    
    for (NSDictionary *info in dataArray) {
        GFTradeVo *vo = [GFTradeVo new];
        vo.range_first_id = info[@"range_first_id"];
        vo.range_second_id = info[@"range_second_id"];
        vo.range_third_name = info[@"range_third_name"];
        vo.range_third_name_en = info[@"range_third_name_en"];
        
        [dataVo addObject:vo];

        //NSLog(@"%@",info);

    }
    block(dataVo,nil);

}


@end
