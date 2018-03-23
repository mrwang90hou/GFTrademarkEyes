//
//  UIView+GF_Frame.h
//  AliPayHome
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GF_Frame)
@property (assign, nonatomic) CGFloat gf_x;
@property (assign, nonatomic) CGFloat gf_y;
@property (assign, nonatomic) CGFloat gf_width;
@property (assign, nonatomic) CGFloat gf_height;

@property (assign, nonatomic) CGFloat gf_left;
@property (assign, nonatomic) CGFloat gf_top;
@property (assign, nonatomic) CGFloat gf_right;
@property (assign, nonatomic) CGFloat gf_bottom;

@property (assign, nonatomic) CGSize gf_size;
@end
