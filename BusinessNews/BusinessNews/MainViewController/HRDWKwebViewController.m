//
//  HJBWKwebViewController.m
//  HJBBaseASC
//
//  Created by luanxu on 16/1/26.
//  Copyright © 2016年 hjb. All rights reserved.
//

#import "HRDWKwebViewController.h"
#import "HRDWKwebViewController+WBJS_Bridge.h"


@interface HRDWKwebViewController ()
@property (strong, nonatomic, readwrite            ) NSString               *userName;
@property (strong, nonatomic, readwrite            ) NSString               *userMoble;
@property (strong, nonatomic, readwrite            ) UIImageView            *failImageView;
@property (strong, nonatomic, readwrite, nullable  ) WKWebView              *baseWebView;
@property (strong, nonatomic, readwrite, nullable  ) UIProgressView         *progressView;
@property (strong, nonatomic, readwrite            ) UIButton               *backButton;

@end

@implementation HRDWKwebViewController
#pragma mark - lifeCycle
- (instancetype)initWithUrl:(NSString *)urlString{
    
    self = [self init];
    if (self) {
        self.urlString = urlString;
    }

    return self;
}
-(instancetype)init{
    self = [super init];
    
    if ([self conformsToProtocol:@protocol(BaseWKwebViewDelegate)]) {
        self.child = (id <BaseWKwebViewDelegate>)self;
    }
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:KHJBRefreshDataNotification object:nil]subscribeNext:^(id x) {
//        [self refreshData];
//    }];
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addCustomView];
    [self setWebViewJavascriptBridge];
    [self getUserInfo];
    
    @weakify(self);
    [RACObserve(self,self.baseWebView.estimatedProgress)subscribeNext:^(id x) {
        @strongify(self);
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.baseWebView.estimatedProgress animated:YES];
            
            if(self.baseWebView.estimatedProgress >= 1.0f) {
                
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
                
            }
    }];
    
    [[RACObserve(self,buttonImage)deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(NSString *imageName) {
//        @strongify(self);
    }];
    
    [[RACObserve(self,self.baseWebView.title)deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(NSString * title) {
        @strongify(self);
        self.title = self.baseWebView.title;
        
        if ([self.child respondsToSelector:@selector(webViewTitleFromHtml:)]) {
            [self.child webViewTitleFromHtml:self.title];
        }
    }];
    
    [[self.functionButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if ([self.child respondsToSelector:@selector(navButtonAction)]) {
            [self.child navButtonAction];
        }
    }];
    
    [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([self.baseWebView canGoBack]) {
            [self.baseWebView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}
#pragma mark - system Method
- (void)dealloc{
    //移除KVO

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //TODO:可以在这里执行清除缓存的操作
}

#pragma mark - WKNavigationDelegate,WKUIDelegate

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    //    DLog(@"%@",message.body);
}
//准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{}
//已开始加载页面，可以在这一步向view中添加一个过渡动画
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{}
//页面已全部加载，可以在这一步把过渡动画去掉
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (error != nil) {
        _failImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kSCreenWidth-300)/2, (kSCreenHeight-300)/2-64, 300, 300)];
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"bg_fail.png" ofType:nil];
        _failImageView.image = [UIImage imageWithContentsOfFile:filePath];
        [self.baseWebView addSubview:_failImageView];
    }
}

// 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
//    NSString *urlString = navigationAction.request.URL.absoluteString;
   
    //TODO:在这里截取url，做相应的操作
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    decisionHandler(WKNavigationResponsePolicyAllow);
}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//    completionHandler(NSURLSessionAuthChallengeUseCredential);
//
//}
// 接口的作用是打开新窗口委托
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    return nil;
}
// js 里面的alert实现，如果不实现，网页的alert函数无效
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];

    [self presentViewController:alertController animated:YES completion:^{}];
}

// js 里面的alert实现，如果不实现，网页的alert函数无效
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
 
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt
                                                                             message:defaultText
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(@"");
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(@"");
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}
#pragma mark - CustomDelegate

- (void)userLoginAgainSuccess{
    [self setNewCookieWithUserInfoToWebView];
}
- (void)userLoginFailure{

}
#pragma mark - eventResponse

#pragma mark - publicMethod

- (void)setNewCookieWithUserInfoToWebView{
    [_baseWebView.configuration.userContentController addUserScript:[self getCookie]];
    [_baseWebView reloadFromOrigin];
}
- (void)backWebViewTwice{
    NSArray *vcArr = self.navigationController.viewControllers;
    for (UIViewController *vc in vcArr) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    NSString *js = @"function goBack(){"
    "if(/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)){"
    "if(window.history.length>2){"
    "window.history.go(-2);"
    "}else{"
    "return false;}"
    "}}"
    "goBack();";
    [self.baseWebView evaluateJavaScript:js completionHandler:^(id _Nullable other, NSError * _Nullable error) {
        if (other != nil) {
            BOOL isBack = [other boolValue];
            if (isBack) {
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    
}


#pragma mark - private methods
- (void)addCustomView{
    //设置进度条
    [self.baseWebView addSubview:self.progressView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.leftBarButtonItem = item;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:self.functionButton];
    self.navigationItem.rightBarButtonItem = item2;
}

- (void)getUserInfo{

}
- (WKUserScript *)getCookie{
    
    NSString *cookie = [NSString stringWithFormat:@"document.cookie = 'platform=2;path=/';"
                        "document.cookie = 'hrdBt=%@;path=/';",[self getSeq]==nil?@"":[self getSeq]];
    if ([USER_DEFAULT objectForKey:KHRDUT] != nil) {
        cookie = [NSString stringWithFormat:@"%@document.cookie = 'hrdUt=%@;path=/';",cookie,[USER_DEFAULT objectForKey:KHRDUT]];
    }
    WKUserScript *cookieScript = [[WKUserScript alloc]initWithSource:cookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    return cookieScript;
}


#pragma mark - gettersAndSetters

- (void)setWebInfo:(NSString *)webInfo{
    if (_webInfo != webInfo) {
        _webInfo = webInfo;
    }
}
- (WKWebView *)baseWebView{
    if (_baseWebView == nil) {
        // 为cookie里传值
        WKUserContentController *userVC = [[WKUserContentController alloc]init];
        [userVC addUserScript:[self getCookie]];
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.selectionGranularity = WKSelectionGranularityCharacter;
        configuration.userContentController   = userVC;
        [configuration.userContentController addScriptMessageHandler:self name:@""];
        WKWebView * webView                   = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kSCreenWidth, kSCreenHeight-64) configuration:configuration];
        webView.navigationDelegate            = self;
        webView.UIDelegate                    = self;
        NSURL *url                            = [NSURL URLWithString:self.urlString];
        NSMutableURLRequest *request          = [[NSMutableURLRequest alloc]initWithURL:url];
        [webView loadRequest:request];
        [webView rac_valuesAndChangesForKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew observer:self];
        [webView rac_valuesAndChangesForKeyPath:@"title" options:NSKeyValueObservingOptionNew observer:self];
        _baseWebView = webView;
    }
    return _baseWebView;
}

- (UIProgressView *)progressView{

    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 1, kSCreenWidth, 1);
        _progressView.progress = 0.1f;
        
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor greenColor];
        [_progressView setProgress:0.0 animated:YES];

    }
    return _progressView;
}

- (UIButton *)functionButton{
    if (_functionButton == nil) {
        _functionButton   = [UIButton buttonWithType:UIButtonTypeCustom];
        _functionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    [_functionButton setImage:[UIImage imageNamed:self.buttonImage] forState:UIControlStateNormal];
    [_functionButton setTitle:self.buttonString forState:UIControlStateNormal];
    if ([self.buttonImage isEqualToString:@"flbintroduce.png"]||[self.buttonString isEqualToString:@"充值"]){
        _functionButton.frame           = CGRectMake(0, 0, 50, 30);
        _functionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    }else{
        _functionButton.frame           = CGRectMake(0, 0, 80, 30);
        _functionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _functionButton;
}
- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 30, 30);
        [_backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.baseWebView = nil;
}

@end

