//
//  UIImage+imageWithColor.m
//  tranb
//
//  Created by 耿功发 on 14/11/25.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import "UIImage+imageWithColor.h"

@implementation UIImage (imageWithColor)

+ (UIImage *) imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    return [UIImage imageWithColor:color size:rect.size];
    
    /*
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
     */
}

+ (UIImage *) imageWithColor:(UIColor *) color size:(CGSize) size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**生成0.5像素宽度的横线图片*/
+ (UIImage *)imageForHorizontalLineWithColor:(UIColor *)color {
    /**
     高度设置为0.5的原因：
     在1.720之前，一直没有做屏幕适配，i6,i6p都是简单粗暴直接放大的。如果把高度设置为1.0 ，屏幕绘制的线条就会比较粗
     */
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 0.5f);
    if(WIDTH_SCREEN>320){
        rect.size.height = 1.0f;
    }
    return [UIImage imageWithColor:color size:rect.size];
}

/**生成0.5像素宽度的竖直图片*/
+ (UIImage *)imageForVerticalLineWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 0.5f, 1.0f);
    if(WIDTH_SCREEN>320){
        rect.size.width = 1.0f;
    }
    return [UIImage imageWithColor:color size:rect.size];
}

@end
