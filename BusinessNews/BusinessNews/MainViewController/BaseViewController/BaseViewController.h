//
//  BaseViewController.h
//  YouPlay
//
//  Created by 小白 on 13-8-21.
//  Copyright (c) 2013年 邱新鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toast+UIView.h"

typedef NS_ENUM(NSUInteger, NavigationBarItemType) {
    NavigationBarItemType_Bg,
    NavigationBarItemType_Left,
    NavigationBarItemType_Right,
};
@class tranbAppDelegate;

static NSString * const BaseViewControllerAnimationKey = @"BaseViewControllerAnimationKey";

@interface BaseViewController : UIViewController{
//    UIImageView *navBarHairlineImageView;
}

@property (nonatomic) BOOL navigationBarHidden;
@property (nonatomic, strong) UIImageView *backGroundView;

@property (nonatomic, copy) void (^BaseActionFinish)(void);  // 公用的回调

#pragma mark - navigationbar
//添加左边按钮
- (void)addLeftBar:(NSString *)title action:(SEL)action;
//添加右边按钮
- (void)addRightBar:(NSString *)title action:(SEL)action;
//显示当前视图
- (void)showWithView:(UIView *)parentView;
//消失视图
- (void)dismissParentView;

#pragma mark -
- (void)setBackBarButton;
- (void)setBackBarButtonWithTitleWithoutArrow:(NSString *)txt;
/**
 imageName:可为nil,使用默认的返回行为（popViewController）
 */
- (void)setBackBarButtonWithTitle:(NSString *)txt imgName:(NSString *)imageName;

- (void)setBackBarButton:(id)target sel:(SEL)action;

#pragma mark -

-(void)setLeftBarWithThemeColorBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
- (void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
- (void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
-(void)setRightBarWithBtn:(NSString *)title color:(UIColor*)color action:(SEL)action;
/**右边导航栏两个按钮*/
-(void)setRightBarWithButtonLeft:(NSString *)titleLeft
                       imageName:(NSString *)imageNameLeft
                          action:(SEL)actionLeft
                     buttonRight:(NSString *)titleRight
                       imageName:(NSString *)imageNameRight
                          action:(SEL)actionRight;
/**
 为那些没有继承BaseViewController的类提供 Naviationbar的返回按钮样式
 */
+ (void)resetBackBarButton:(UINavigationItem*)navigationItem target:(id)target action:(SEL)sel;

- (UIButton *)buildButton:(NSString *)title imageName:(NSString *)imageName action:(SEL)action aAlignment:(NavigationBarItemType)aAlignment;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//IOS7无状态栏高度
//float originY(float Originy);
/* 可以重写这个方法 */
- (void)backBarButtonItem:(id)sender;
- (tranbAppDelegate *)appDelegate;

/**找到navigationbar下隐藏线*/
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

/**设置navigationbar是否透明*/
- (void)translucentNavigationBar:(BOOL)translucent;


/**
 *  带badge的可点击view
 *
 *  @param imageName    图片
 *  @param aBadgeString 数字
 *  @param target       调用对象
 *  @param action       执行方法
 *
 *  @return view
 *
 *  @since 1.640
 */
//+ (UIView*)badgeButtonWithImageName:(NSString*)imageName
//                             target:(id)target
//                             action:(SEL)action
//                           badgeTag:(NSInteger)badgeTag;
//
//+ (UIView*)badgeButtonWithTitleTxt:(NSString*)titleTxt
//                            target:(id)target
//                            action:(SEL)action
//                          badgeTag:(NSInteger)badgeTag;


#pragma mark -
// 添加loading
- (void)showloadingView;
- (void)showloadingViewWithString:(NSString *)aString;
- (void)hiddeloadingView;
- (void)hiddeloadingViewWithoutDelay;
- (void)hiddeloadingViewFinish:(void (^)())aFinish;
/**
 显示一个在屏幕底部的提示文字；
 */
- (void)makeToastInBottom:(NSString*)msg;

//  当按home键的时候会调用这个方法
- (void)dealActionWhenHomeKeyPress;

// 添加手势 用于自动取消键盘事件  子类需要重写此方法
- (void)hideKeyBoardTap;
- (void)handleTapGesture:(UIGestureRecognizer*)gesture;
- (void)extensionMethodForHideKeyBoardTap;
- (void)addTapGesture;
- (void)removeTapGestures;
- (void)removeGestures;

#pragma mark network
/**
 下面两个方法由子类实现，调用前必须先进行可用性检查
 */
- (void)onNetworkSuccess:(id)data;

- (void)onNetworkError:(NSError *)error;

@end
