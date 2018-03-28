//
//  GFRangeDao.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/18.
//  Copyright © 2016年 gf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFBaseDao.h"

@interface GFRangeDao : GFBaseDao

/**
 *  根据类别或群组ID，搜索数据
 *  @param firstID  类别ID
 *  @param secondID 类似群ID
 *  @return 搜索结果
 */
+ (NSMutableArray *)searchDataByFirstID:(NSString *)firstID SecondID:(NSString *)secondID;

/**
 *  根据商品名称，搜索数据
 *  @param name 商品名称
 *  @return 搜索结果
 */
+ (NSMutableArray *)searchDataByName:(NSString *)name;

@end
