//
//  HRDWKwebViewController+WBJS_Bridge.m
//  Huarongdao
//
//  Created by daixc on 16/8/26.
//  Copyright © 2016年 daixc. All rights reserved.
//

#import "HRDWKwebViewController+WBJS_Bridge.h"
#import "WKWebViewJavascriptBridge.h"
@implementation HRDWKwebViewController (WBJS_Bridge)
- (void)setWebViewJavascriptBridge{

    /****** 加载桥梁对象 ******/
        [WKWebViewJavascriptBridge enableLogging];
        /******  ******/
    
        /****** 初始化 ******/
        self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.baseWebView];
    
        [self.bridge setWebViewDelegate:self];
    
    [self.bridge registerHandler:@"" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        //TODO:webview回调
    }];
}



- (NSString *)changeStringFormat:(NSString *)string{
    
    NSString * messageJSON = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    
    return messageJSON;
}
@end
