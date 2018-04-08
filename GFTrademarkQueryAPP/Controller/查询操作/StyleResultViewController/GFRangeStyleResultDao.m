//
//  GFRangeStyleResultDao.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/18.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFRangeStyleResultDao.h"
#import "GFRangeStyleResultVo.h"
#import "FMDB.h"

@implementation GFRangeStyleResultDao

/*先行放弃该方案
//+ (NSMutableArray *)searchDataByFirstID:(NSString *)firstID SecondID:(NSString *)secondID {
//
//    NSMutableArray *dataALL = [[NSMutableArray alloc] init];
//    NSMutableArray *dataTemp = [[NSMutableArray alloc] init];
//    FMDatabase *database = [[FMDatabase alloc] initWithPath:[self getRangeDBPath]];
//    if ([database open]) {
//        NSLog(@"打开数据库成功");
////        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_range_second WHERE range_first_id LIKE '%%%@%%' AND range_second_id LIKE '%%%@%%'", firstID, secondID];
//        //查找firstID, secondID
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_range_third WHERE range_first_id LIKE '%%%@%%' AND range_second_id LIKE '%%%@%%'", firstID, secondID];
//        NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM table_range_third WHERE range_first_id LIKE '%%%@%%' AND range_second_id LIKE '%%%@%%'", firstID, secondID];
//        NSString *sql3 = [NSString stringWithFormat:@"SELECT * FROM table_range_third WHERE range_first_id LIKE '%%%@%%' AND range_second_id LIKE '%%%@%%'", firstID, secondID];
////        NSLog(@"%%%@%%",firstID);
////        NSLog(@"%%%@%%",secondID);
//        FMResultSet *fmResultSet1 = [database executeQuery:sql1];
//        FMResultSet *fmResultSet2 = [database executeQuery:sql2];
//        FMResultSet *fmResultSet3 = [database executeQuery:sql3];
//
//        while ([fmResultSet3 next]) {
//            GFRangeStyleResultVo *rangeVo = [[GFRangeStyleResultVo alloc] init];
//            rangeVo.firstRangeID = [fmResultSet3 stringForColumn:@"range_first_id"];     //14230
//            rangeVo.firstRangeName = [fmResultSet1 stringForColumn:@"range_first_name"]; //45
//            rangeVo.secondRangeID = [fmResultSet3 stringForColumn:@"range_second_id"];  //14230
//            rangeVo.secondRangeName = [fmResultSet2 stringForColumn:@"range_second_name"];//486
//            rangeVo.thirdRangeID = [fmResultSet3 stringForColumn:@"range_third_id"];//14230
//            rangeVo.thirdRangeName = [fmResultSet3 stringForColumn:@"range_third_name"];//14230
//            rangeVo.thirdRangeNameInEnglish = [fmResultSet3 stringForColumn:@"range_third_name_en"];//14230
//
//            if (dataTemp.count == 0) {
//                [dataTemp addObject:rangeVo];
//            } else {
//                GFRangeStyleResultVo *lastVo = [dataTemp objectAtIndex:dataTemp.count -1];
//                if ([lastVo.firstRangeID isEqualToString:rangeVo.firstRangeID]) {
//                    [dataTemp addObject:rangeVo];
//                } else {
//                    [dataALL addObject:dataTemp];
//                    dataTemp = [[NSMutableArray alloc] init];
//                    [dataTemp addObject:rangeVo];
//                }
//            }
//        }
//        if (dataTemp.count > 0) {
//            [dataALL addObject:dataTemp];
//        }
//        [fmResultSet close];
//        [database close];
//        return dataALL;
//    } else {
//        NSLog(@"打开数据库失败");
//        return nil;
//    }
//}
*/
+ (NSMutableArray *)searchDataByFirstID:(NSString *)firstID SecondID:(NSString *)secondID {
    
    NSMutableArray *dataALL = [[NSMutableArray alloc] init];
    NSMutableArray *dataTemp = [[NSMutableArray alloc] init];
    FMDatabase *database = [[FMDatabase alloc] initWithPath:[self getRangeDBPath]];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_range_second WHERE range_first_id LIKE '%%%@%%' AND range_second_id LIKE '%%%@%%'", firstID, secondID];
        FMResultSet *fmResultSet = [database executeQuery:sql];
        while ([fmResultSet next]) {
            GFRangeStyleResultVo *rangeVo = [[GFRangeStyleResultVo alloc] init];
            rangeVo.firstRangeID = [fmResultSet stringForColumn:@"range_first_id"];
            rangeVo.secondRangeID = [fmResultSet stringForColumn:@"range_second_id"];
            rangeVo.secondRangeName = [fmResultSet stringForColumn:@"range_second_name"];
            
            if (dataTemp.count == 0) {
                [dataTemp addObject:rangeVo];
            } else {
                GFRangeStyleResultVo *lastVo = [dataTemp objectAtIndex:dataTemp.count -1];
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
        NSLog(@"%%%@%%",name);
        NSString *sql = [NSString stringWithFormat:@"SELECT range_first_id, range_second_id, range_third_name ,range_third_name_en FROM table_range_third WHERE range_third_name LIKE '%%%@%%'", name];// or  range_third_name_en LIKE ’%%%@%%‘
        FMResultSet *fmResultSet = [database executeQuery:sql];
        while ([fmResultSet next]) {
            GFRangeStyleResultVo *rangeVo = [[GFRangeStyleResultVo alloc] init];
            rangeVo.firstRangeID = [fmResultSet stringForColumn:@"range_first_id"];
            rangeVo.secondRangeID = [fmResultSet stringForColumn:@"range_second_id"];
            rangeVo.thirdRangeName = [fmResultSet stringForColumn:@"range_third_name"];
            rangeVo.thirdRangeNameInEnglish = [fmResultSet stringForColumn:@"range_third_name_en"];
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
    return [[NSBundle mainBundle] pathForResource:@"niceclass_2018_detail" ofType:@"sqlite"];
}

@end
