//
//  AutoFitDeviceFontSize.h
//  tranb
//
//  Created by Smalltask on 16/4/18.
//  Copyright © 2016年 cmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoFitDeviceFontSize : NSObject

#pragma mark - 字体处理相关
/**
 根据当前屏幕宽度及传入的字号，得到最佳的字号的尺寸；
 调用方法：[autoFitDeviceFontSize:13,14,15,nil]
 13:iPhone5下使用的字号，第一个参数
 14:iPHone6下使用的字号，第二个参数
 15:iPhone6P下使用的字号，第三个参数
 注意：如果省略第3个参数，则在iPhone6p时，返回第2个参数的值；如果第2个参数也被省略，则返回第1个参数的值；
 */
+ (CGFloat)autoFitDeviceFontSize:(CGFloat)fontSize,...;

+ (CGFloat)autoFontSize:(CGFloat)i5 i6:(CGFloat)i6 i6p:(CGFloat)i6p;

@end
