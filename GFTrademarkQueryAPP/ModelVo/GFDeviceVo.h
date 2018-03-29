//
//  GFDeviceVo.h
//  GFTrademark
//
//  Created by ios－梁家安 on 2017/7/10.
//  Copyright © 2017年 gf. All rights reserved.
//

#import "GFBaseVo.h"

@interface GFDeviceVo : GFBaseVo
@property (nonatomic, strong) NSNumber *mid;
@property (nonatomic, copy) NSString *range_third_name;
@property (nonatomic, assign) bool isMainEquimment;
@property (nonatomic, assign) bool isAuthorize;
@property (nonatomic, copy) NSString *remark;
@end
