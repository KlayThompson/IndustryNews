//
//  HJBWKwebViewController.h
//  HJBBaseASC
//
//  Created by luanxu on 16/1/26.
//  Copyright © 2016年 hjb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"
#import "WKWebViewJavascriptBridge.h"

@class HRDWKwebViewController;

@protocol BaseWKwebViewDelegate <NSObject>

@required

- (void)webViewTitleFromHtml:(NSString * _Nullable )title;

@optional

- (void)backAction;

- (void)navButtonAction;

@end

@interface HRDWKwebViewController : UIViewController<WKNavigationDelegate, WKUIDelegate,
WKScriptMessageHandler> {
}
@property (strong, nonatomic, nullable, readonly  ) WKWebView             *baseWebView;
@property (strong, nonatomic, nullable, readonly  ) UIProgressView        *progressView;
@property (copy  , nonatomic, nullable            ) NSString              *urlString;
@property (copy  , nonatomic, nullable            ) NSString              *buttonString;
@property (copy  , nonatomic, nullable            ) NSString              *buttonImage;
@property (copy  , nonatomic, nullable            ) NSString              *webInfo;
@property (strong, nonatomic, nullable            ) UIButton              *functionButton;
@property (weak  , nonatomic, nullable            ) NSObject<BaseWKwebViewDelegate> *child;
@property (strong, nonatomic, nullable            ) WKWebViewJavascriptBridge *bridge;

- (nullable instancetype)initWithUrl:(NSString * _Nullable)urlString;



@end
