//
//  UIImageView+HTC.m
//  btc
//
//  Created by ios－梁家安 on 16/6/14.
//  Copyright © 2016年 shs. All rights reserved.
//

#import "UIImageView+HTC.h"

@implementation UIImageView (HTC)

-(void)assignmentWithImageView:(NSString*)name model:(UIViewContentMode)contentMode
{
    if (![name isEqualToString:@""]) {
      self.image = [UIImage imageNamed:name];
    }
    self.contentMode = contentMode;
    if (contentMode == UIViewContentModeScaleAspectFill)
    {
         [self setClipsToBounds:YES];
    }
}

-(void)changShapeWidth:(CGFloat)width
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = width;
}

@end
