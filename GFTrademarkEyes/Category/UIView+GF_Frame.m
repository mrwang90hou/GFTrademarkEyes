//
//  UIView+GF_Frame.m
//  AliPayHome
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "UIView+GF_Frame.h"

@implementation UIView (GF_Frame)
-(void)setGf_x:(CGFloat)gf_x{
        CGFloat y = self.frame.origin.y;
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        self.frame = CGRectMake(gf_x, y, width, height);
}
-(CGFloat)gf_x{
    return self.frame.origin.x;
}
-(void)setGf_y:(CGFloat)gf_y{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, gf_y, width, height);
}
-(CGFloat)gf_y{
    return self.frame.origin.y;
}
-(void)setGf_width:(CGFloat)gf_width{
    CGRect frame = self.frame;
    frame.size.width = gf_width;
    self.frame = frame;
}
-(CGFloat)gf_width{
    return self.frame.size.width;
}

-(void)setGf_height:(CGFloat)gf_height{
    CGRect frame = self.frame;
    frame.size.height = gf_height;
    self.frame = frame;
}

-(CGFloat)gf_height{
    return self.frame.size.height;
}


-(void)setGf_left:(CGFloat)gf_left{
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(gf_left, y, width, height);
}
-(CGFloat)gf_left{
    return self.frame.origin.x;
}


-(void)setGf_top:(CGFloat)gf_top{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, gf_top, width, height);
}
-(CGFloat)gf_top{
    return self.frame.origin.y;
}
-(void)setGf_right:(CGFloat)gf_right{
    CGRect frame = self.frame;
    frame.origin.x = gf_right - frame.size.width;
    self.frame = frame;
}
-(CGFloat)gf_right{
    return self.frame.origin.x + self.frame.size.width;
}
-(void)setGf_bottom:(CGFloat)gf_bottom{
    CGRect frame = self.frame;
    frame.origin.y = gf_bottom - frame.size.height;
    self.frame = frame;
}
-(CGFloat)gf_bottom{
     return self.frame.origin.y + self.frame.size.height;
}

-(CGSize)gf_size {
    return self.frame.size;
}

- (void)setGf_size:(CGSize)gf_size {
    CGRect frame = self.frame;
    frame.size = gf_size;
    self.frame = frame;
}
@end
