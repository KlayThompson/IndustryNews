//
//  ColorDefinition.h
//  tranb
//
//  Created by 耿功发 on 15/2/25.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

// @{
// @name 颜色相关
//! 参数格式为：0xFFFFFF
#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
//! 参数格式为：222,222,222
#define kColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.f]
#define kColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:a]
// @end

#define kColorClear [UIColor clearColor]

//所有界面的背景色
//[UIColor colorWithRed:227./255. green:227./255. blue:227./255. alpha:1.0]

//主题的颜色，例如navigationbar、按钮等；
#define COLOR_THEME                 [UIColor redColor]

#define COLOR_GRAY_BG               [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0]

#define COLOR_UI_BG                 [UIColor colorWithRed:233./255. green:235./255. blue:239./255. alpha:1.0]

#define COLOR_TIME                  [UIColor colorWithRed:142./255. green:142./255 blue:142./255 alpha:1]

#define COLOR_TABLE_BG              [UIColor colorWithRed:247./255. green:247./255. blue:247./255. alpha:1.0]

#define COLOR_TABLECELL_BG          [UIColor whiteColor]

#define COLOR_TABLE_BG              [UIColor colorWithRed:247./255. green:247./255. blue:247./255. alpha:1.0]

#define COLOR_TABLECELL_Text        [UIColor colorWithRed:34./255. green:35./255. blue:38./255. alpha:1.0]

#define COLOR_TABLECELL_VALUE       [UIColor colorWithRed:129./255. green:129./255. blue:129./255. alpha:1.0]

#define COLOR_TABLECELL_Selected    [UIColor colorWithRed:247./255. green:248./255. blue:249./255. alpha:1.0]

#define COLOR_BLUE_TITLE            [UIColor colorWithRed: 52./255. green:95./255. blue:176./255. alpha:1]
#define COLOR_Orange_Placeholder    [UIColor colorWithRed: 255./255. green:114./255. blue:0./255. alpha:1]

#define COLOR_GrayDark_TITLE        [UIColor colorWithRed:50./255. green:50./255. blue:50./255. alpha:1]
#define COLOR_DECK_TITLE            [UIColor colorWithRed:108./255. green:108./255. blue:108./255. alpha:1]
#define COLOR_DECK_TITLE_Gray       [UIColor colorWithRed:135./255. green:135./255. blue:135./255. alpha:1]
//#define COLOR_DECK_TITLE            [UIColor blackColor];
#define COLOR_DECK_VIEW_BACKGROUND  [UIColor colorWithRed:247./255. green:247./255. blue:247./255. alpha:1]
#define COLOR_GRAY_TIMELINENAME     [UIColor colorWithRed: 71./255. green:71./255. blue:71./255. alpha:1]



#pragma mark - 分割线
#define COLOR_LINE_LIGHT            [UIColor colorWithRed:233./255. green:233./255. blue:233./255. alpha:1]
#define COLOR_LINE_DARK             [UIColor colorWithRed:211./255. green:211./255. blue:211./255. alpha:1]
#define COLOR_LINE                  [UIColor colorWithRed:200./255. green:200./255. blue:200./255. alpha:1]



#pragma mark - 背景色
#define COLOR_CLEAR                 [UIColor clearColor]
#define COLOR_BG_MMM                [UIColor colorWithRed:233./255. green:235./255. blue:239./255. alpha:1]

#define COLOR_PLACEHOLDER           [UIColor colorWithRed:0.556863 green:0.556863 blue:0.576471 alpha:1]
//profile的顶部使用的颜色

//列表中使用的颜色
#define COLOR_TITLE_MAIN_IN_TABLE   [UIColor colorWithRed:52./255. green:52./255. blue:52./255. alpha:1.0]
#define COLOR_TITLE_MAIN_IN_TABLE_MEMBER   [UIColor colorWithRed:205./255. green:149./255. blue:69./255. alpha:1.0]
#define COLOR_TITLE_SUB_IN_TABLE    [UIColor colorWithRed:52./255. green:52./255. blue:52./255. alpha:1.0]
#define COLOR_TITLE_3RD_IN_TABLE    [UIColor colorWithRed:52./255. green:52./255. blue:52./255. alpha:1.0]
#define COLOR_DESCRITPION_TEXT      [UIColor colorWithRed:52./255. green:52./255. blue:52./255. alpha:1.0]
#define COLOR_REASON_TEXT           [UIColor colorWithRed:86./255. green:121./255. blue:186./255. alpha:1.0]
#define COLOR__TITLE_INVITE_NAME_IN_TABLE [UIColor colorWithRed:50./255. green:50./255. blue:50./255. alpha:1.0]
#define COLOR__TITLE_INVITE_DESCRIPTION_IN_TABLE [UIColor colorWithRed:135./255. green:135./255. blue:135./255. alpha:1.0]
#define COLOR_BG_INSUDTRYPANEL [UIColor colorWithRed:228./255. green:231./255. blue:233./255. alpha:1.0]
#define COLOR_INSUDTRYPANEL_TEXTCOLOR_UNSELECT [UIColor colorWithRed:80./255. green:80./255. blue:80./255. alpha:1.0]
#define COLOR_GRAY_STROKE   [UIColor colorWithRed:199./255. green:199./255. blue:199./255. alpha:1]
//会议profile里使用的颜色
#define COLOR_CONTENT_IN_MEETING_PROFILE   [UIColor blackColor]

//profile列表项左侧的蓝色标题
#define COLOR_LABLE_BLUE [UIColor colorWithRed:83./255. green:132./255. blue:206./255. alpha:1.0]

//button
#define COLOR_BUTTON_INVALID_GRAY           [UIColor colorWithRed:112./255. green:112./255. blue:112./255. alpha:1.0]
#define COLOR_BUTTON_TITLE_INVALID_GRAY     [UIColor colorWithRed:162./255. green:162./255. blue:162./255. alpha:1.0]

#pragma mark 1.800 
//订单系统中，新增加的主题蓝色，是一种风骚的蓝色
#define COLOR_ORDER_BLUE kColorWithHex(0x338cff)
#define kColorFont       kColorWithHex(0x282828)
#define kColorTableCellTitle        [UIColor colorWithRed:38/255. green:31/255. blue:28/255. alpha:1.0]
#define kColorTableCellValue        [UIColor colorWithRed:136/255. green:133/255. blue:131/255. alpha:1.0]

#pragma mark 分类
#define categoryDefaultColor [UIColor colorWithHexString:@"0x2357d4"]
#define categoryTagBgColor [UIColor colorWithHexString:@"0x2257d3"]

//找布的主题颜色，最后统一修改
#define kColorTheme COLOR_THEME


