//
//  GFRangeRootViewController.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/17.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBasicController.h"

/**
 * 商品范围类型
 */
typedef enum {
    RangeTypeFirst = 0,       // 类别
    RangeTypeSecond         // 类似群
} RangeType;

/**
 * 商品范围选择结果回调
 */
@protocol GFChooseRangeDataResultDelegate <NSObject>

- (void)chooseRangeResultType:(RangeType)type Data:(NSMutableArray *)datas;

-(void)chooseRangeAllData;

@end

@interface GFRangeRootViewController : GFBasicController

@property (nonatomic, weak) id<GFChooseRangeDataResultDelegate> dataResultDelegate;

@end
