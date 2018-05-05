//
//  ImageCodeResultViewController.h
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/13.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFBasicController.h"

// 返回图形要素选择结果
@protocol GFImageCodeDataResultDelegate <NSObject>

- (void)imageCodeResultData:(NSString *)data;

@end

@interface ImageCodeResultViewController : GFBasicController

@property (nonatomic, weak) id<GFImageCodeDataResultDelegate> dataResultDelegate;

@end
