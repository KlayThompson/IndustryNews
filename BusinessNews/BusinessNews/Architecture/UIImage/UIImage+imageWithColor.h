//
//  UIImage+imageWithColor.h
//  tranb
//
//  Created by 耿功发 on 14/11/25.
//  Copyright (c) 2014年 cmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (imageWithColor)

/**
 注意：
 下面两个方法，使用相同的颜色值，仍然会有色差的
 色差是由于 imageWithColor:方法默认使用 (1,1)像素图片，但是实际在界面中绘制经常用0.5像素，因此出现色差
 在使用时要注意区分；
 */
+ (UIImage *) imageWithColor:(UIColor *)color;
+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize) size;

/**生成0.5像素宽度的横线图片*/
+ (UIImage *)imageForHorizontalLineWithColor:(UIColor *)color;

/**生成0.5像素宽度的竖直图片*/
+ (UIImage *)imageForVerticalLineWithColor:(UIColor *)color;

@end
