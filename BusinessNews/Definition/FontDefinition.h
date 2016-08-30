//
//  FontDefinition.h
//  tranb
//
//  Created by 耿功发 on 15/2/25.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#import "AutoFitDeviceFontSize.h"

/*
//缩写：Font Size
#define FS(fontSizeI5,fontSizeI6,fontSizeI6p) [AutoFitDeviceFontSize autoFitDeviceFontSize:(CGFloat)fontSizeI5,(CGFloat)fontSizeI6,(CGFloat)fontSizeI6p,nil]

//缩写：Font Size Auto
#define FSA(foneSizeI5) [AutoFitDeviceFontSize autoFitDeviceFontSize:(CGFloat)foneSizeI5,(CGFloat)foneSizeI5+1.2,(CGFloat)foneSizeI5+2.,nil]

//缩写：Font Size Cell
#define FSC(foneSizeI5) FSS(foneSizeI5)
//[AutoFitDeviceFontSize autoFitDeviceFontSize:(CGFloat)foneSizeI5,(CGFloat)foneSizeI5+2.,(CGFloat)foneSizeI5+4.,nil]

//按屏幕比例来缩放尺寸 Font Size Scale
#define FSS(foneSizeI5) [AutoFitDeviceFontSize autoFitDeviceFontSize:(CGFloat)foneSizeI5,(CGFloat)foneSizeI5*1.17,(CGFloat)foneSizeI5*1.17*1.1,nil]
 */



//缩写：Font Size
#define FS(fontSizeI5,fontSizeI6,fontSizeI6p) [AutoFitDeviceFontSize autoFontSize:(CGFloat)fontSizeI5 i6:(CGFloat)fontSizeI6 i6p:(CGFloat)fontSizeI6p]

//缩写：Font Size Auto
#define FSA(foneSizeI5) [AutoFitDeviceFontSize autoFontSize:(CGFloat)foneSizeI5 i6:(CGFloat)foneSizeI5+1.2 i6p:(CGFloat)foneSizeI5+2.]

//缩写：Font Size Cell
#define FSC(foneSizeI5) FSS(foneSizeI5)
//[AutoFitDeviceFontSize autoFitDeviceFontSize:(CGFloat)foneSizeI5,(CGFloat)foneSizeI5+2.,(CGFloat)foneSizeI5+4.,nil]

//按屏幕比例来缩放尺寸 Font Size Scale
#define FSS(foneSizeI5) [AutoFitDeviceFontSize autoFontSize:(CGFloat)foneSizeI5 i6:(CGFloat)foneSizeI5*1.17 i6p:(CGFloat)foneSizeI5*1.17*1.1]


#define Font10      [UIFont systemFontOfSize:FS(10.,12.,13.)]
#define FontB10     [UIFont boldSystemFontOfSize:FS(10.,12.,13)]
#define Font11      [UIFont systemFontOfSize:FS(11.,13.,14.)]
#define FontB11     [UIFont boldSystemFontOfSize:FS(11.,13.,14.)]
#define Font12      [UIFont systemFontOfSize:FS(12.,14.,15.)]
#define FontB12     [UIFont boldSystemFontOfSize:FS(12,14,15)]
#define Font13      [UIFont systemFontOfSize:FS(13.,15.,16.)]
#define FontB13     [UIFont boldSystemFontOfSize:FS(13.,15.,16.)]
#define Font14      [UIFont systemFontOfSize:FS(14,16,17)]
#define FontB14     [UIFont boldSystemFontOfSize:FS(14.,16.,17.)]
#define Font15      [UIFont systemFontOfSize:FS(15.,17.,18.)]
#define FontB15     [UIFont boldSystemFontOfSize:FS(15.,17.,18.)]
#define Font16      [UIFont systemFontOfSize:FS(16.,18.,19.)]
#define FontB16     [UIFont boldSystemFontOfSize:FS(16.,18.,19.)]
#define Font17      [UIFont systemFontOfSize:FS(17.,19.,20.)]
#define FontB17     [UIFont boldSystemFontOfSize:FS(17.,19.,20.)]
#define Font18      [UIFont systemFontOfSize:FS(18.,20.,21.)]

//profile的顶部使用的字体
#define FONT_TITLE_MAIN             [UIFont boldSystemFontOfSize:FS(14.,15.,15.)]
#define FONT_TITLE_SUB              [UIFont systemFontOfSize:FS(12.,14.,14.)]

//邀请通讯录 微博 好友
#define FONT_TITLE_INVITE_NAME_IN_TABLE [UIFont boldSystemFontOfSize:17.]
#define FONT_TITLE_INVITE_DESCRIPTION_IN_TABLE [UIFont systemFontOfSize:FS(14.,15.,16.)]
//列表中使用的字体
#define FONT_TITLE  FS(14,16,17)
#define FONT_TITLE_MAIN_IN_TABLE    [UIFont boldSystemFontOfSize:FS(14.,15.,16.)]
#define FONT_TITLE_SUB_IN_TABLE     [UIFont systemFontOfSize:FS(12.,14.,15.)]
#define FONT_TITLE_3RD_IN_TABLE     [UIFont boldSystemFontOfSize:FS(10.,12.,13.)]

#define FONT_DESC  FS(12,14,15)
#define FONT_DESCRIPTION_TEXT       [UIFont systemFontOfSize:FS(12.,14.,14.)]




