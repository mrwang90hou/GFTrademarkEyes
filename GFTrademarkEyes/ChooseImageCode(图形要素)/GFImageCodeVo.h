//
//  GFImageCodeVo.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/12.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBaseVo.h"

@interface GFImageCodeVo : GFBaseVo

@property (nonatomic, strong) NSString *imageCode;
@property (nonatomic, strong) NSString *imageDesc;
@property (nonatomic, weak) GFImageCodeVo *parentImageCodeVo;

@property (nonatomic, strong) NSMutableArray *childrenVos;
@property BOOL isOpen;
@property BOOL isCheck;
@property BOOL isRoot;

@end
