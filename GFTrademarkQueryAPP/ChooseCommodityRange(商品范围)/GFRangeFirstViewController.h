//
//  GFRangeFirstViewController.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/17.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBasicController.h"
#import "GFRangeRootViewController.h"

@interface GFRangeFirstViewController : GFBasicController

@property (nonatomic, weak) id<GFChooseRangeDataResultDelegate> dataResultDelegate;

@property (nonatomic , strong) NSMutableArray *firstArray;

@end
