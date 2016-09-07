//
//  NewsDetailViewController.m
//  BusinessNews
//
//  Created by KlayThompson on 16/9/5.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "ArticleHtmlCodeTranslate.h"
#import "SysTools.h"
#import "AppDelegate.h"
#import "UIView+Size.h"
#import "MWPhotoBrowser.h"
#import "BNApi.h"
#import <ShareSDK/ShareSDK.h>
#import "TTShareHelper.h"


#define scrollViewHeight (APP_FRAME.size.height-44)
#define CollectNewsList @"CollectNewsList"

@interface NewsDetailViewController ()<UIWebViewDelegate,MWPhotoBrowserDelegate> {

    UIWebView *webViewCurrent;
    UIView *shareIconContainerView;

}

@property (nonatomic, strong) NewsDetailModel *currentNewsDetailUnit;
@property (nonatomic, strong) NewsListUnit *currentNewsListunit;
@property (nonatomic, strong) MWPhoto *aPhoto;
@property (nonatomic, strong) NSMutableArray<NewsListUnit*> *currentCollectNewsArray;

@end

@implementation NewsDetailViewController

- (instancetype)initWithNewsDetailModel:(NewsDetailModel *)model newsListUnit:(NewsListUnit *)unit
{
    self = [super init];
    if (self) {
        _currentNewsDetailUnit = model;
        _currentNewsListunit = unit;
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:COLOR_THEME];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentCollectNewsArray = [NSMutableArray new];
    
    if (ARRAY_IS_NIL([AppDelegate sysDirector].collectNewsArray)) {
        
    } else {
        self.currentCollectNewsArray = [AppDelegate sysDirector].collectNewsArray;
    }
    
    self.view.backgroundColor = COLOR_UI_BG;
    
    [self setUpSubVews];
}

- (void)setUpSubVews {

    webViewCurrent = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, scrollViewHeight-44)];
    webViewCurrent.dataDetectorTypes=!UIDataDetectorTypePhoneNumber;
    webViewCurrent.backgroundColor = [UIColor whiteColor];
    webViewCurrent.delegate = self;
    webViewCurrent.alpha = 0;
    
    [self.view addSubview:webViewCurrent];
    
    [self performSelector:@selector(func_ShowCurrentWebView) withObject:nil afterDelay:0.3];
    
    [self paintSnsIcons];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorWithHex(0x403c3c)}];
    
    [self.navigationController.navigationBar setBarTintColor:kColorWithRGBA(255, 255, 255, 0.9)];
    //右边导航栏收藏功能
    if ([self verifyIsNewsCollect]) {
        [self setRightBarWithBtn:nil imageName:@"topicon_collection_a" action:@selector(cancleCollectButtonClick)];
    } else {
        [self setRightBarWithBtn:nil imageName:@"topicon_collection_b" action:@selector(collectButtonClick)];
    }
    
    //设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //设置返回按钮
    [self setBackBarButtonWithTitle:nil imgName:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"backbutto"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 10, 17);
    [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)paintSnsIcons {
    CGFloat labelWidth = FSS(50);
    CGFloat py = APP_FRAME.size.height-44-44;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, py, labelWidth, 44)];
    lable.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    lable.text = @"分享到:";
    lable.font = Font11;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor darkGrayColor];
    [self.view addSubview:lable];
    
    
    shareIconContainerView = [[UIView alloc] initWithFrame:CGRectMake(labelWidth, py, WIDTH_SCREEN - labelWidth, 44)];
    shareIconContainerView.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [self.view addSubview:shareIconContainerView];
    
    
    CGFloat iconHPadding = 5.0f;
    CGFloat iconWidth = (shareIconContainerView.width - 7*iconHPadding)/5;
    
    for (NSUInteger index = 0; index < 5; index ++) {
        CGPoint origin = CGPointMake((iconWidth + iconHPadding)*index + iconHPadding, 2);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.origin = origin;
        btn.size = CGSizeMake(iconWidth, shareIconContainerView.height - 4);
        [shareIconContainerView addSubview:btn];
        
        ///////
        if (index == 0){
            [btn setImage:[UIImage imageNamed:@"bottom_snswechat_c"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareToWechatSession) forControlEvents:UIControlEventTouchUpInside];
        }else if (index == 1){
            [btn setImage:[UIImage imageNamed:@"bottom_snswechat_moment_c"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareToWechatTimeLine) forControlEvents:UIControlEventTouchUpInside];
        }else if (index == 4){
            [btn setImage:[UIImage imageNamed:@"bottom_snsweibo"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareToWeibo) forControlEvents:UIControlEventTouchUpInside];
        }else if (index == 3){
            [btn setImage:[UIImage imageNamed:@"bottom_snsqzone_c"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareToQQZone) forControlEvents:UIControlEventTouchUpInside];
        }else if (index == 2){
            [btn setImage:[UIImage imageNamed:@"bottom_snsqq_c"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareToQQFriend) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - Actions
-(void)func_ShowCurrentWebView {
    

    webViewCurrent.frame=CGRectMake(0, 0, WIDTH_SCREEN, scrollViewHeight-44);
    
    NSString *htmlString = [ArticleHtmlCodeTranslate getHtmlByStringContact:self.currentNewsDetailUnit.content
                                                                      title:self.currentNewsDetailUnit.articleName
                                                                       time:[NSString stringWithFormat:@"%@",self.currentNewsDetailUnit.publishTime]
                                                                       from:self.currentNewsDetailUnit.websitName];
    //    NSString *imageUrlString = @"http://ww3.sinaimg.cn/large/9b61f9b0jw1dtoj5cm0ghj.jpg";
    //    NSString *yourText = article.content;
    //    NSString *htmlString = [NSString stringWithFormat:@"<img style=\"max-width: 310px;height:auto;width:expression(this.width > 310 ? \"310px\" : this.width);\" src='%@' /><br><b>%@</b>", imageUrlString, yourText];
    
    [webViewCurrent loadHTMLString:htmlString baseURL:nil];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    webViewCurrent.alpha=1.0;
    [UIView commitAnimations];
}

- (BOOL)verifyIsNewsCollect {

    for (int i = 0; i < [AppDelegate sysDirector].collectNewsArray.count; i++) {
        NewsListUnit *unit = [[AppDelegate sysDirector].collectNewsArray objectAtIndex:i];
        if ([unit.newsId isEqual:self.currentNewsListunit.newsId]) {
            return YES;
        }
    }
    return NO;
}

//收藏
- (void)collectButtonClick {

    [self.currentCollectNewsArray addObject:self.currentNewsListunit];
    [AppDelegate sysDirector].collectNewsArray = self.currentCollectNewsArray;
    [self saveCollectNewsToLocal];
    [self setRightBarWithBtn:nil imageName:@"topicon_collection_a" action:@selector(cancleCollectButtonClick)];
    [[AppDelegate sysDirector] showToastinCenter:@"收藏成功"];
    
    //统计
    [BNAPI sys_pushTrackEventWithType:@"click_like" name:@"收藏的点击" value:nil rmtInId:nil websitid:self.currentNewsListunit.websitId imei:nil bannerId:nil Block:^(BaseCmd *model, NSError *error) {
            //do nothing
    }];
}

//取消收藏
- (void)cancleCollectButtonClick {
    for (int i = 0; i < [AppDelegate sysDirector].collectNewsArray.count; i++) {
        NewsListUnit *unit = [[AppDelegate sysDirector].collectNewsArray objectAtIndex:i];
        if ([unit.newsId isEqual:self.currentNewsListunit.newsId]) {
            [[AppDelegate sysDirector].collectNewsArray removeObjectAtIndex:i];
        }
    }
    [self saveCollectNewsToLocal];
    [self setRightBarWithBtn:nil imageName:@"topicon_collection_b" action:@selector(collectButtonClick)];
    [[AppDelegate sysDirector] showToastinCenter:@"取消成功"];
}

- (void)saveCollectNewsToLocal {
    NSData *tempSubmitOrderCmd = [NSKeyedArchiver archivedDataWithRootObject:[AppDelegate sysDirector].collectNewsArray];
    [[NSUserDefaults standardUserDefaults] setObject:tempSubmitOrderCmd forKey:CollectNewsList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)backButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *picName = [[request URL] absoluteString];
    SLOG(@"picName is %@",picName);
    if ([picName hasPrefix:@"pic:"]) {
        self.aPhoto=[MWPhoto photoWithURL:[NSURL URLWithString:[picName substringFromIndex:4]]];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayNavArrows = YES;
        browser.displayActionButton = YES;
        //        browser.wantsFullScreenLayout = NO;
        browser.displayActionButton = NO;
        [self.navigationController pushViewController:browser animated:YES];
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {

    return 1;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return self.aPhoto;
}

#pragma mark - SNS
- (void)shareToWechatSession {
    [[TTShareHelper shareHelper] shareArticleWith:self.currentNewsDetailUnit industryId:self.currentNewsListunit.industryId shareType:SSDKPlatformSubTypeWechatSession currentViewController:self];
}

- (void)shareToWechatTimeLine {
    [[TTShareHelper shareHelper] shareArticleWith:self.currentNewsDetailUnit industryId:self.currentNewsListunit.industryId shareType:SSDKPlatformSubTypeWechatTimeline currentViewController:self];
}

- (void)shareToQQFriend {
    [[TTShareHelper shareHelper] shareArticleWith:self.currentNewsDetailUnit industryId:self.currentNewsListunit.industryId shareType:SSDKPlatformSubTypeQQFriend currentViewController:self];
}

- (void)shareToQQZone {
    [[TTShareHelper shareHelper] shareArticleWith:self.currentNewsDetailUnit industryId:self.currentNewsListunit.industryId shareType:SSDKPlatformSubTypeQZone currentViewController:self];
}

- (void)shareToWeibo {
    [[TTShareHelper shareHelper] shareArticleWith:self.currentNewsDetailUnit industryId:self.currentNewsListunit.industryId shareType:SSDKPlatformTypeSinaWeibo currentViewController:self];
}

- (NSString *)title {
    return @"头条详情";
}
@end
