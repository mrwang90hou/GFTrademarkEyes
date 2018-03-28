//
//  GFRangeDao.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/18.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFRangeDao.h"
#import "GFRangeVo.h"
#import "FMDB.h"

@implementation GFRangeDao

+ (NSMutableArray *)searchDataByFirstID:(NSString *)firstID SecondID:(NSString *)secondID {
    
    NSMutableArray *dataALL = [[NSMutableArray alloc] init];
    NSMutableArray *dataTemp = [[NSMutableArray alloc] init];
    FMDatabase *database = [[FMDatabase alloc] initWithPath:[self getRangeDBPath]];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_range_second WHERE range_first_id LIKE '%%%@%%' AND range_second_id LIKE '%%%@%%'", firstID, secondID];
        FMResultSet *fmResultSet = [database executeQuery:sql];
        while ([fmResultSet next]) {
            GFRangeVo *rangeVo = [[GFRangeVo alloc] init];
            rangeVo.firstRangeID = [fmResultSet stringForColumn:@"range_first_id"];
            rangeVo.secondRangeID = [fmResultSet stringForColumn:@"range_second_id"];
            rangeVo.secondRangeName = [fmResultSet stringForColumn:@"range_second_name"];
            
            if (dataTemp.count == 0) {
                [dataTemp addObject:rangeVo];
            } else {
                GFRangeVo *lastVo = [dataTemp objectAtIndex:dataTemp.count -1];
                if ([lastVo.firstRangeID isEqualToString:rangeVo.firstRangeID]) {
                    [dataTemp addObject:rangeVo];
                } else {
                    [dataALL addObject:dataTemp];
                    dataTemp = [[NSMutableArray alloc] init];
                    [dataTemp addObject:rangeVo];
                }
            }
        }
        if (dataTemp.count > 0) {
            [dataALL addObject:dataTemp];
        }
        [fmResultSet close];
        [database close];
        return dataALL;
    } else {
        NSLog(@"打开数据库失败");
        return nil;
    }
}

+ (NSMutableArray *)searchDataByName:(NSString *)name {
    NSMutableArray *resultDatas = [[NSMutableArray alloc] init];
    FMDatabase *database = [[FMDatabase alloc] initWithPath:[self getRangeDBPath]];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        NSString *sql = [NSString stringWithFormat:@"SELECT range_first_id, range_second_id, range_third_name FROM table_range_third WHERE range_third_name LIKE '%%%@%%'", name];
        FMResultSet *fmResultSet = [database executeQuery:sql];
        while ([fmResultSet next]) {
            GFRangeVo *rangeVo = [[GFRangeVo alloc] init];
            rangeVo.firstRangeID = [fmResultSet stringForColumn:@"range_first_id"];
            rangeVo.secondRangeID = [fmResultSet stringForColumn:@"range_second_id"];
            rangeVo.thirdRangeName = [fmResultSet stringForColumn:@"range_third_name"];
            [resultDatas addObject:rangeVo];
        }
        [fmResultSet close];
        [database close];
        return resultDatas;
    } else {
        NSLog(@"打开数据库失败");
        return nil;
    }
}

/**
 *  获取类似群数据库文件路径
 *  @return 文件路径
 */
+ (NSString *)getRangeDBPath {
    return [[NSBundle mainBundle] pathForResource:@"db_range" ofType:@"sqlite"];
}

@end
