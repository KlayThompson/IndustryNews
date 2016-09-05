//
//  NewsDetailViewController.m
//  BusinessNews
//
//  Created by KlayThompson on 16/9/5.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "NewsDetailViewController.h"


#define scrollViewHeight (APP_FRAME.size.height-44)

@interface NewsDetailViewController ()<UIWebViewDelegate> {

    UIWebView *webViewCurrent;

}

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    webViewCurrent=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, scrollViewHeight-44)];
    webViewCurrent.dataDetectorTypes=!UIDataDetectorTypePhoneNumber;
    webViewCurrent.backgroundColor=[UIColor whiteColor];
    webViewCurrent.delegate=self;
    //    webViewCurrent.scrollView.delegate=self;
    webViewCurrent.alpha=0;
    [self.view addSubview:webViewCurrent];
    
    [self performSelector:@selector(func_loadCurrendArticle) withObject:nil afterDelay:0.3];

}

- (void)func_loadCurrendArticle {
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
