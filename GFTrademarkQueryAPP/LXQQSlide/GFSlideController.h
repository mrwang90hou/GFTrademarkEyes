//
//  GFSlideController.h
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFBasicController.h"

@interface GFSlideController : GFBasicController
+(instancetype)initWithLeftVC:(GFBasicController *)leftVc mainVc:(UIViewController *)mainVc;
-(void)closeDrawer;//关闭抽屉
-(void)openDrawer;//打开抽屉
@end
