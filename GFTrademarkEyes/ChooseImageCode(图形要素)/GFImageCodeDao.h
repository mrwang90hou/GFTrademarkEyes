//
//  GFImageCodeDao.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/12.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBaseDao.h"
#import "GFImageCodeVo.h"

@interface GFImageCodeDao : GFBaseDao

+ (GFImageCodeVo *)getAllImageCodeVo;
+ (NSMutableArray *)searchImageCodeLike:(NSString *)string;

@end
