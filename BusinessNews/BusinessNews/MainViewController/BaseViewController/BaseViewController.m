//
//  BaseViewController.m
//  YouPlay
//
//  Created by 小白 on 13-8-21.
//  Copyright (c) 2013年 邱新鹏. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BaseNavigationController.h"
#import "Definition.h"
#import "MBProgressHUD.h"
//#import "tranbAppDelegate.h"
#import "CRNavigationBar.h"
#import "UIImage+imageWithColor.h"
#import "ColorDefinition.h"
#import "FontDefinition.h"
#import "SysInfo.h"
#import "SysTools.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"

//#import "QXPLoginBtn.h"
//#import "MyViewController.h"
//#import "AKTabBarController.h"

@interface BackParentView : UIView

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, weak) UIView *parentView;
- (void)removed;

@end

@implementation BackParentView
- (id)initWithFrame:(CGRect)frame parentView:(UIView *)view{

    if ((self=[super initWithFrame:frame])) {
        self.backgroundColor=[UIColor clearColor];
        self.parentView=view;
        self.backView=[[UIView alloc] initWithFrame:self.bounds];
        self.backView.autoresizingMask=UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        self.backView.autoresizesSubviews=YES;
        self.backView.backgroundColor=[UIColor blackColor];
        self.backView.alpha=0.8;
        [self addSubview:self.backView];
        
        [self addSubview:self.parentView];
        self.parentView.center=self.center;
        
    }
    return self;
}
- (void)removed{

    [self.parentView removeFromSuperview];
}
- (void)dealloc{

    self.backView=nil;
   
}
@end

@interface BaseViewController()<UIGestureRecognizerDelegate>{
    
    MBProgressHUD *mProgressHUD;
}
@property (nonatomic, strong)BackParentView *parentView;

- (void)dismissParentView;



@end

@implementation BaseViewController

- (void)dealloc{
    mProgressHUD = nil;
    self.BaseActionFinish = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dissMiss{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
//    tranbAppDelegate *appDelegate = [self appDelegate];
//    appDelegate.navModelView = nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    [CustomNavigationBar replaceNavigationController:self.navigationController];
//    [self setFd_interactivePopMaxAllowedInitialDistanceToLeftEdge:100];
    if(self.navigationController.viewControllers.count>1){
        [self setBackBarButton];
    }
//    //设置代理
//    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
//    //启用系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dealActionWhenHomeKeyPress)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    _navigationBarHidden=navigationBarHidden;
    self.navigationController.navigationBar.hidden=_navigationBarHidden;
    
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置代理
//    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
//    
//    //启用系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
  
}

 //添加左边按钮
- (void)addLeftBar:(NSString *)title action:(SEL)action{

    [self setLeftBarWithBtn:title imageName:nil action:action];
}
//添加右边按钮
- (void)addRightBar:(NSString *)title action:(SEL)action{

     [self setRightBarWithBtn:title imageName:nil action:action];
}

- (void)showWithView:(UIView *)parentView{

    self.parentView=[[BackParentView alloc] initWithFrame:self.view.bounds parentView:parentView];
   // self.parentView.center=CGPointMake(self.view.width/2, self.view.height/2);
    [self.view addSubview:self.parentView];
    
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = 0.5;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [self.parentView.layer addAnimation:forwardAnimation
                                  forKey:BaseViewControllerAnimationKey];
    
}

#pragma mark - NavigationBar

- (void)dismissParentView{
    __weak BaseViewController *wself=self;
    
    CABasicAnimation *reverseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    reverseAnimation.duration = 0.5;
    reverseAnimation.beginTime = 0;
    reverseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    reverseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    reverseAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    [self.parentView.layer addAnimation:reverseAnimation
                                  forKey:BaseViewControllerAnimationKey];
    
    double delayInSeconds = 0.4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        wself.parentView.hidden=YES;
        [wself.parentView removed];
        [wself.parentView.layer removeAnimationForKey:BaseViewControllerAnimationKey];
        [wself.parentView removeFromSuperview];
        wself.parentView=nil;
        
    });
}

- (void)setBackBarButton:(id)target sel:(SEL)action
{
    UIButton *btnReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReturn setFrame:CGRectMake(0, 0, 70, 44)];
    [btnReturn setTitle:@"返回" forState:UIControlStateNormal];
    [btnReturn setImage:[UIImage imageNamed:@"backButton4NoniOS7"] forState:UIControlStateNormal];
    [btnReturn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [btnReturn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btnReturn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnReturn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)setBackBarButtonWithTitleWithoutArrow:(NSString *)txt {
    [self setBackBarButtonWithTitle:txt imgName:nil];
}

- (void)setBackBarButton{
    
    NSString *imageName = @"";
    imageName = @"backButton4NoniOS7";
    
    [self setBackBarButtonWithTitle:@"返回" imgName:imageName];
    
}

/**
 imageName:可为nil,使用默认的返回行为（popViewController）
 */
- (void)setBackBarButtonWithTitle:(NSString *)txt imgName:(NSString *)imageName {
    UIColor *textColor = nil;
    
    //backbutton4ios7
    textColor = [UIColor whiteColor];

    UIButton *button = [self buildButton:txt imageName:imageName action:@selector(backBarButtonItem:) aAlignment:NavigationBarItemType_Left];
    [button setBackgroundImage:[SysTools imageViaColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    button.titleEdgeInsets = UIEdgeInsetsMake(2, 6, 0, -15);
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    UIBarButtonItem *aItem1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *aItem0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    aItem0.style = UIBarButtonSystemItemFixedSpace;
    aItem0.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[aItem0,aItem1];
}



/**
 为那些没有继承BaseViewController的类提供 Naviationbar的返回按钮样式
 */
+ (void)resetBackBarButton:(UINavigationItem*)navigationItem target:(id)target action:(SEL)sel{
    
    UIColor *textColor = nil;
    
    //backbutton4ios7
    NSString *imageName = @"";
    textColor = [UIColor whiteColor];
    
    imageName = @"backButton4NoniOS7";
  
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    UIButton *button = [baseVC buildButton:@"返回" imageName:imageName action:sel aAlignment:NavigationBarItemType_Left];
    [button removeTarget:baseVC action:sel forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[SysTools imageViaColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    button.titleEdgeInsets = UIEdgeInsetsMake(2, 6, 0, -15);
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    UIBarButtonItem *aItem1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *aItem0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    aItem0.style = UIBarButtonSystemItemFixedSpace;
    aItem0.width = -10;
    
    navigationItem.leftBarButtonItems = @[aItem0,aItem1];

    
}

-(void)setLeftBarWithThemeColorBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action
{
    UIButton *button = [self buildButton:title imageName:inmageName action:action aAlignment:NavigationBarItemType_Left];
    [button setTitleColor:COLOR_THEME forState:UIControlStateNormal];

    UIBarButtonItem *items1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[items1,negativeSeperator];

}

-(void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action
{
    
    UIButton *button = [self buildButton:title imageName:inmageName action:action aAlignment:NavigationBarItemType_Left];
    
    UIBarButtonItem *items1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[items1,negativeSeperator];
    
}

-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action
{
    UIButton *button = [self buildButton:title imageName:inmageName action:action aAlignment:NavigationBarItemType_Left];
    
    UIBarButtonItem *items1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[negativeSeperator,items1];
}

-(void)setRightBarWithButtonLeft:(NSString *)titleLeft
                       imageName:(NSString *)imageNameLeft
                          action:(SEL)actionLeft
                     buttonRight:(NSString *)titleRight
                       imageName:(NSString *)imageNameRight
                          action:(SEL)actionRight
{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    
    UIButton *buttonLeft = [self buildButton:titleLeft imageName:imageNameLeft action:actionLeft aAlignment:NavigationBarItemType_Left];
    UIButton *buttonRight = [self buildButton:titleRight imageName:imageNameRight action:actionRight aAlignment:NavigationBarItemType_Right];
    
    buttonLeft.frame = CGRectMake(60, 7, 15, 15);
    buttonRight.frame = CGRectMake(85, 0, 68, 30);
    
    [bgView addSubview:buttonLeft];
    [bgView addSubview:buttonRight];
    
    UIBarButtonItem *items1 = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    
    
    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[negativeSeperator,items1];
}

-(void)setRightBarWithBtn:(NSString *)title color:(UIColor*)color action:(SEL)action {
    UIButton *button = [self buildButton:title imageName:nil action:action aAlignment:NavigationBarItemType_Left];
    [button setTitleColor:color forState:UIControlStateNormal];
    
    UIBarButtonItem *items1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[negativeSeperator,items1];
}



- (UIButton *)buildButton:(NSString *)title imageName:(NSString *)imageName action:(SEL)action aAlignment:(NavigationBarItemType)aAlignment{

    CGFloat width = 0.0f;
    CGSize size = CGSizeZero;
    if (title) {
//        size = [title sizeWithFont:Font17 constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByCharWrapping];
        size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 21) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        
        width += size.width;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIImage *image = nil;
    if (imageName) {
        image = [UIImage imageNamed:imageName];
        switch (aAlignment) {
            case NavigationBarItemType_Bg:
            {
                width = MAX(width,image.size.width);
                [button setBackgroundImage:image forState:UIControlStateNormal];
                 button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
            case NavigationBarItemType_Left:
            {
                width += image.size.width + 5;
                
                [button setImage:image forState:UIControlStateNormal];
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
            case NavigationBarItemType_Right:
            {
                width += image.size.width + 5;
                [button setImage:image forState:UIControlStateNormal];
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
                
            default:
                break;
        }
    }
    
    if (image)
    {
        [button setFrame:CGRectMake(0, 0, MAX((width),40), MAX(30, image.size.height))];
    }
    else
    {
        [button setFrame:CGRectMake(0, 0, MAX((width),40),30)];
    }
    
    if (action)
    {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }

    return button;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSArray *ctrs = self.navigationController.viewControllers;
    UIViewController *lastCtr = (UIViewController *)ctrs.lastObject;
    if ([lastCtr isKindOfClass:[viewController class]]) {
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;  // 可以修改为任何方向
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{

    return  UIInterfaceOrientationPortrait;
}
-(BOOL)shouldAutorotate{
    
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

/* 可以重写这个方法 */
- (void)backBarButtonItem:(id)sender{

    NSArray *array = self.navigationController.childViewControllers;
    if (array.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
//        tranbAppDelegate *appDelegate = [self appDelegate];
//        appDelegate.navModelView = nil;
    }
    
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/**设置navigationbar是否透明*/
- (void)translucentNavigationBar:(BOOL)translucent{
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    if(translucent){
        
        navBarHairlineImageView.hidden = YES;
        self.navigationController.navigationBar.translucent = YES;
        
        UIColor * color = [UIColor whiteColor];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[color colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
        
        CRNavigationBar *crnavbar = (CRNavigationBar*)self.navigationController.navigationBar;
        [crnavbar displayColorLayer:NO];
        
    }else{
        
        navBarHairlineImageView.hidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        
        UIColor * color = COLOR_THEME;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[color colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
        
        CRNavigationBar *crnavbar = (CRNavigationBar*)self.navigationController.navigationBar;
        [crnavbar displayColorLayer:YES];
        
    }
}


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
//                            target:(id)target
//                            action:(SEL)action
//                           badgeTag:(NSInteger)badgeTag
//{
//    UIView *leftBarButtonView=[[UIView alloc] init];
//    leftBarButtonView.backgroundColor = [UIColor clearColor];
//    UIImage *imageLeft=[UIImage imageNamed:imageName];
//    UIButton* aButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [aButton setImage:imageLeft forState:UIControlStateNormal];
//    aButton.frame=CGRectMake(0, 0 , imageLeft.size.width, imageLeft.size.height);
//    aButton.backgroundColor = [UIColor clearColor];
//    
//    [aButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [leftBarButtonView addSubview:aButton];
//    leftBarButtonView.frame=CGRectMake(0, 0, aButton.frame.size.width, aButton.frame.size.height);
//    
//    CustomBadge *badge = [CustomBadge customBadgeWithString:@""
//                                            withStringColor:[UIColor whiteColor]
//                                             withInsetColor:[UIColor redColor]
//                                             withBadgeFrame:YES
//                                        withBadgeFrameColor:[UIColor whiteColor]
//                                                  withScale:0.8
//                                                withShining:YES];
//    badge.userInteractionEnabled=NO;
//    badge.tag = badgeTag;
//    [badge setFrame:CGRectMake(aButton.frame.size.width + 5.0f - badge.frame.size.width , -5.0f, badge.frame.size.width, badge.frame.size.height)];
//    [leftBarButtonView addSubview:badge];
//    badge.hidden = YES;
//    
//    if (23 + badge.frame.size.width > imageLeft.size.width + 4) {
//        int offset = 23 + badge.frame.size.width - imageLeft.size.width - 4;
//        CGRect rect = badge.frame;
//        rect.origin.x -= offset;
//        badge.frame = rect;
//    }
//    
//    return leftBarButtonView;
//}

//
//+ (UIView*)badgeButtonWithTitleTxt:(NSString*)titleTxt
//                            target:(id)target
//                            action:(SEL)action
//                          badgeTag:(NSInteger)badgeTag
//{
//    UIImage *imageLeft=[SysTools imageViaColor:[UIColor clearColor]];
//    
//    UIView *leftBarButtonView=[[UIView alloc] init];
//    leftBarButtonView.backgroundColor = [UIColor clearColor];
//    UIButton* aButton=[UIButton buttonWithType:UIButtonTypeCustom];
//
//    [aButton setTitle:titleTxt forState:UIControlStateNormal];
//    [aButton setBackgroundImage:imageLeft forState:UIControlStateNormal];
//    aButton.titleLabel.font = [UIFont systemFontOfSize:FS(14, 15, 15)];
//    
//    CGSize buttonSize = CGSizeMake(68, 30);
//    aButton.frame=CGRectMake(0, 0 , buttonSize.width, buttonSize.height);
//    [aButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
//
//    aButton.backgroundColor = [UIColor clearColor];
//    
//    [aButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [leftBarButtonView addSubview:aButton];
//    leftBarButtonView.frame=CGRectMake(0, 0, aButton.frame.size.width, aButton.frame.size.height);
//    
//    CustomBadge *badge = [CustomBadge customBadgeWithString:@""
//                                            withStringColor:[UIColor whiteColor]
//                                             withInsetColor:[UIColor redColor]
//                                             withBadgeFrame:YES
//                                        withBadgeFrameColor:[UIColor whiteColor]
//                                                  withScale:0.8
//                                                withShining:YES];
//    badge.userInteractionEnabled=NO;
//    badge.tag = badgeTag;
//    [badge setFrame:CGRectMake(aButton.frame.size.width + 5.0f - badge.frame.size.width , -5.0f, badge.frame.size.width, badge.frame.size.height)];
//    [leftBarButtonView addSubview:badge];
//    badge.hidden = YES;
//    
//    if (23 + badge.frame.size.width > buttonSize.width + 4) {
//        int offset = 23 + badge.frame.size.width - buttonSize.width - 4;
//        CGRect rect = badge.frame;
//        rect.origin.x -= offset;
//        badge.frame = rect;
//    }
//    
//    return leftBarButtonView;
//}

#pragma mark -
- (tranbAppDelegate *)appDelegate{
    
    return (tranbAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)showloadingViewWithString:(NSString *)aString{
 
    if (mProgressHUD == nil) {
        
        mProgressHUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    }
    
    mProgressHUD.label.text =  aString;
    [mProgressHUD showAnimated:YES];
}

- (void)showloadingView{
    if(mProgressHUD && mProgressHUD.alpha>0){
        return;
    }
    [self showloadingViewWithString:nil];
}

- (void)hiddeloadingView{

    [self hiddeloadingViewFinish:nil];
}

- (void)hiddeloadingViewFinish:(void (^)())aFinish{
    
    if (mProgressHUD) {
        
        if (aFinish) {
            mProgressHUD.completionBlock = ^{
                aFinish();
            };
        } else {
            
        }
        [mProgressHUD hideAnimated:YES afterDelay:0.3f];
    }
}

- (void)hiddeloadingViewWithoutDelay {
    
    if (mProgressHUD) {
        
        [mProgressHUD hideAnimated:YES];
    }
}

/**
 显示一个在屏幕底部的提示文字；
 */
- (void)makeToastInBottom:(NSString *)msg {
    [self.view.window makeToast:msg duration:2. position:@"bottom"];
}

#pragma mark -

// 子类重写
- (void)dealActionWhenHomeKeyPress{};

#pragma mark- CommonMethods;
// 添加手势 用于自动取消键盘事件  子类需要重写此方法
- (void)hideKeyBoardTap {
    [self removeTapGestures];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture {
    [self hideKeyBoardTap];
    
}

- (void)extensionMethodForHideKeyBoardTap{
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    if ([touch.view isKindOfClass:[UIControl class]]) {
        return NO;
    }
    return YES;
}

- (void)addTapGesture {
    [self removeTapGestures];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)removeTapGestures {
    NSArray *gestures = [self.view gestureRecognizers];
    for (UIGestureRecognizer* gesture in gestures) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            [self.view removeGestureRecognizer:gesture];
        }
    }
    [self extensionMethodForHideKeyBoardTap];
}

- (void)removeGestures {
    NSArray *gestures = [self.view gestureRecognizers];
    
    for (UIGestureRecognizer* gesture in gestures) {
        [self.view removeGestureRecognizer:gesture];
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        
    }
    
    return YES;
    
}

#pragma mark network
/**
 下面两个方法由子类实现，调用前必须先进行可用性检查
 */
- (void)onNetworkSuccess:(id)data {
    NSAssert(0,@"onNetworkSuccess 应当由子类实现");
}

- (void)onNetworkError:(NSError *)error {
    NSAssert(0,@"onNetworkError 应当由子类实现");
}

@end
