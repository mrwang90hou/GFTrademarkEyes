//
//  GFTradeDao.h
//  GFTrademark
//
//  Created by ios－梁家安 on 16/8/17.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBaseDao.h"
#import "GFTradeVo.h"
//@class GFCardOrderVo;

@interface GFTradeDao : GFBaseDao

/**
 *  获取使用日志列表
 *
 *  参数看文档
 */
+ (void)ID:(NSString *)ID
     block:(void(^)(NSMutableArray *numberVo,NSError *error))block;

@end
