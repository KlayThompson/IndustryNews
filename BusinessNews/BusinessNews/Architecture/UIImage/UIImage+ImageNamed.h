//
//  UIImage+ImageNamed.h
//  tranb
//
//  Created by VictorChou on 13-4-1.
//  Copyright (c) 2013年 cmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageNamed)

+ (UIImage *)imageNamedMatch:(NSString *)name;

//参考了在路上，设计如下：
//1.       全尺寸取景，PresetPhoto，本地存放全尺寸照片
//2.       上传文件尺寸上限，设为150KB；压缩参数初始值为0.5；分辨率初始值为1024x768
//3.       分辨率从1024x768开始，如果超过文件尺寸上限，降低分辨率一档，再试，直到下限640x480；可选的档次：1024x768, 800x600, 640x480
//4.       如果分辨率到达下限文件尺寸上限依然无法保证，逐渐降低压缩参数一档

-(UIImage *)compressedImageToUpload;

//修复方向
- (UIImage *)fixOrientationOfImage:(UIImage *)image;

@end
