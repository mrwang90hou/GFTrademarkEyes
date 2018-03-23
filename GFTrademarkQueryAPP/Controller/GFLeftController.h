//
//  GFLeftController.h
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFBasicController.h"
typedef void (^TypeDidClick) (NSString *type,Class targetClass);
@interface GFLeftController : GFBasicController
@property(nonatomic,copy)TypeDidClick typeClick;
@end
