//
//  SizeDefinition.h
//  tranb
//
//  Created by 耿功发 on 15/2/25.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#pragma mark - 尺寸相关
/*---------------------------------------------------尺寸大小-------------------------------------------------*/
#define HEIGHT_VIEW          [UIScreen mainScreen].bounds.size.height - HEIGHT_NAVIGATION_BAR - HEIGHT_STATUSBAR   //正常高度
#define HEIGHT_STATUSBAR     20                      //电池条高度
#define WIDTH_SCREEN         [[UIScreen mainScreen] bounds].size.width      //屏幕宽度
#define HEIGHT_SCREEN        [[UIScreen mainScreen] bounds].size.height     //屏幕高度

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width  [UIScreen mainScreen].bounds.size.width



#define APP_FRAME [[UIScreen mainScreen] applicationFrame]
#define WIN_FRAME [[UIScreen mainScreen] bounds]
// 显示主题内容界面高度
#define kScreen_Height_Content  [UIScreen mainScreen].bounds.size.height - HEIGHT_NAVIGATION_BAR - HEIGHT_STATUSBAR

#define CGRECT_TABLEVIEW    CGRectMake(0, 0, 320, APP_FRAME.size.height-44)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_4 HEIGHT_SCREEN <= 480.0
#define IS_IPHONE_6 HEIGHT_SCREEN == 667.0
#define IS_IPHONE_6P (HEIGHT_SCREEN == 736.0)

#define HEIGHT_TOOLBAR          44
#define HEIGHT_NAVIGATION_BAR   44
#define HEIGHT_SEARCH_BAR       40
#define HEIGHT_SEGMENT_CUSTOMER 40
#define HEIGHT_TABBAR           49
#define HEIGHT_TABLEVIEWCELL_NORMAL FSS(44)

#define WIDTH_INDUSTRY_PANEL  FS(83,90,100)

#define SCROLLWIDTH WIDTH_SCREEN
#define SCROLLHEIGHT  APP_FRAME.size.height-HEIGHT_NAVIGATION_BAR

#define DeckLeftWidth   280
#define DeckRightWidth  60

#define kPaddingLeftWidth 15.0

#pragma mar - timeline
#define HEIGHT_TimelineComment      FS(20,22,24)
/** 每个timeline cell底部的扩散、评论、赞的 toolbar */
#define HEIGHT_TimelineCellToolBar  FS(40,42,44)


#define JPush_UpLoadOriginImgWidth              720
#define JPush_UpLoadImgWidth                    500


