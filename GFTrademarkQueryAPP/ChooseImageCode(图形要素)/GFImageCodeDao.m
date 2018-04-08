//
//  GFImageCodeDao.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/12.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFImageCodeDao.h"
#import "FMDB.h"

@implementation GFImageCodeDao

+ (GFImageCodeVo *)getAllImageCodeVo {
    
    // 数据源
    GFImageCodeVo *result = [[GFImageCodeVo alloc] init];
    
    FMDatabase *database = [[FMDatabase alloc] initWithPath:[self getImageCodeDBPath]];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        
        // 获取第一级目录
        result.childrenVos = [[NSMutableArray alloc] init];
        NSString *sql = @"SELECT * FROM table_image_code WHERE parent_code IS NULL ORDER BY order_id";
        FMResultSet *fmResultSet = [database executeQuery:sql];
        while ([fmResultSet next]) {
            GFImageCodeVo *rootVo = [[GFImageCodeVo alloc] init];
            rootVo.imageCode = [fmResultSet stringForColumn:@"image_code"];
            rootVo.imageDesc = [fmResultSet stringForColumn:@"image_desc"];
            [result.childrenVos addObject:rootVo];
        }
        [fmResultSet close];
        
        // 获取第二级目录
        for (GFImageCodeVo *rootVo in result.childrenVos) {
            rootVo.childrenVos = [[NSMutableArray alloc] init];
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_image_code WHERE parent_code = '%@' ORDER BY order_id", rootVo.imageCode];
            FMResultSet *fmResultSet = [database executeQuery:sql];
            while ([fmResultSet next]) {
                GFImageCodeVo *secodeVo = [[GFImageCodeVo alloc] init];
                secodeVo.imageCode = [fmResultSet stringForColumn:@"image_code"];
                secodeVo.imageDesc = [fmResultSet stringForColumn:@"image_desc"];
                secodeVo.parentImageCodeVo = rootVo;
                [rootVo.childrenVos addObject:secodeVo];
            }
            [fmResultSet close];
        }
        
        // 获取第三级目录
        for (GFImageCodeVo *rootVo in result.childrenVos) {
            for (GFImageCodeVo *secodeVo in rootVo.childrenVos) {
                secodeVo.childrenVos = [[NSMutableArray alloc] init];
                NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_image_code WHERE parent_code = '%@' or parent_code = 'A%@' ORDER BY order_id", secodeVo.imageCode, secodeVo.imageCode];
                
                FMResultSet *fmResultSet = [database executeQuery:sql];
                while ([fmResultSet next]) {
                    GFImageCodeVo *thirdVo = [[GFImageCodeVo alloc] init];
                    thirdVo.imageCode = [fmResultSet stringForColumn:@"image_code"];
                    thirdVo.imageDesc = [fmResultSet stringForColumn:@"image_desc"];
                    thirdVo.parentImageCodeVo = secodeVo;
                    [secodeVo.childrenVos addObject:thirdVo];
                }
                [fmResultSet close];
            }
        }
        
        [database close];
        return result;
    } else {
        NSLog(@"打开数据库失败");
        return nil;
    }
}

+ (NSMutableArray *)searchImageCodeLike:(NSString *)string {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMDatabase *database = [[FMDatabase alloc] initWithPath:[self getImageCodeDBPath]];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM table_image_code WHERE image_desc LIKE '%%%@%%' or image_code like '%%%@%%'", string, string];
        FMResultSet *fmResultSet = [database executeQuery:sql];
        while ([fmResultSet next]) {
            GFImageCodeVo *imageCodeVo = [[GFImageCodeVo alloc] init];
            imageCodeVo.imageCode = [fmResultSet stringForColumn:@"image_code"];
            imageCodeVo.imageDesc = [fmResultSet stringForColumn:@"image_desc"];
            [result addObject:imageCodeVo];
        }
        [fmResultSet close];
        [database close];
        return result;
    } else {
        NSLog(@"打开数据库失败");
        return nil;
    }
}

/**
 *  获取类似群数据库文件路径
 *  @return 文件路径
 */
+ (NSString *)getImageCodeDBPath {
    return [[NSBundle mainBundle] pathForResource:@"db_image_code" ofType:@"sqlite"];
}

@end
