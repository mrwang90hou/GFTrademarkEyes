//
//  GFControlRootController.h
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFBasicController.h"
#import "AdvertisingColumn.h"

static float AD_height = 150;//广告栏高度

@interface GFControlRootController : GFBasicController<UICollectionViewDataSource,UICollectionViewDelegate>{
AdvertisingColumn *_headerView; //广告栏
}
@end
