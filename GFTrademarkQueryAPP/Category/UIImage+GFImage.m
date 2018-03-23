//
//  UIImage+GFImage.m
//  GFTestPod
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "UIImage+GFImage.h"

@implementation UIImage (GFImage)
// 设置图片为不渲染模式
+ (instancetype)GF_imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}
//根据颜色生成图片
+ (UIImage *)GF_imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextAddEllipseInRect(context, rect);
    UIGraphicsEndImageContext();
    return image;

}
-(UIImage*)GF_scaleToSize:(CGSize)size
{
    size = CGSizeMake(size.width  , size.height );
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width , size.height )];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
+ (UIImage *)GF_ClipImageWithImage:(UIImage *)image circleRect:(CGRect)rect radious:(CGFloat) radious{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置裁剪区域
    //    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious];
    [path addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}
//裁剪圆形
+ (UIImage *)GF_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //2.设置剪裁区域
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [path addClip];
    
    //绘制图片
    
    [image drawAtPoint:CGPointZero];
    
    
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //返回新图片
    
    return  newImage;
    
    
    
}

//裁剪带边框的圆形图片
+ (UIImage *)GF_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:( UIColor *)borderColor{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //2、设置边框
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    
    //3、设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2)];
    [clipPath addClip];
    
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
    
}

//裁剪带边框的图片 可设置圆角 边框颜色
+(UIImage *)GF_ClipImageRadiousWithImage:(UIImage *)image circleRect:(CGRect)rect radious:(CGFloat)radious borderWith:(CGFloat)borderW borderColor:( UIColor *)borderColor{
    
    
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //2、设置边框
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious];
    
    [borderColor setFill];
    
    [path fill];
    
    //3、设置裁剪区域
    
    
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2) cornerRadius:radious];
    
    [clipPath addClip];
    
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
    
    
}

@end
