//
//  GFRangeVo.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/18.
//  Copyright © 2016年 gf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFBaseVo.h"

@interface GFRangeVo : GFBaseVo

@property (nonatomic, strong) NSString *dataID;
@property (nonatomic, strong) NSString *firstRangeID;
@property (nonatomic, strong) NSString *firstRangeName;
@property (nonatomic, strong) NSString *secondRangeID;
@property (nonatomic, strong) NSString *secondRangeName;
@property (nonatomic, strong) NSString *thirdRangeID;
@property (nonatomic, strong) NSString *thirdRangeName;
@property (nonatomic, strong) NSString *thirdRangeNameInEnglish;

@property (nonatomic) BOOL isCheck;

@end
