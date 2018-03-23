//
//  UIImage+GFImage.h
//  GFTestPod
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GFImage)
//根据图片名字生成图片 原始渲染
+ (UIImage *)GF_imageWithOriginalName:(NSString *)imageName;
//根据颜色生成图片
+ (UIImage *)GF_imageWithColor:(UIColor *)color;

//图片缩小到固定的size
-(UIImage*)GF_scaleToSize:(CGSize)size;

//裁剪图片自定义圆角
+ (UIImage *)GF_ClipImageWithImage:(UIImage *)image circleRect:(CGRect)rect radious:(CGFloat) radious;


//裁剪圆形图片
+ (UIImage *)GF_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect;


//裁剪带边框的圆形图片
+ ( UIImage *)GF_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:( UIColor *)borderColor;


//裁剪带边框的图片 可设置圆角 边框颜色
+(UIImage *)GF_ClipImageRadiousWithImage:(UIImage *)image circleRect:(CGRect)rect radious:(CGFloat)radious borderWith:(CGFloat)borderW borderColor:( UIColor *)borderColor;

@end
