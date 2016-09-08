//
//  TTShareHelper.m
//  BusinessNews
//
//  Created by KlayThompson on 16/9/7.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "TTShareHelper.h"
#import "SDWebImageManager.h"
#import "UIImage-Extensions.h"
#import "Publish_Definition.h"

@interface TTShareHelper()

@property (nonatomic, strong) BaseViewController *currentBaseViewController;
@property (nonatomic, strong) NewsDetailModel *currentDetailModel;

@end

@implementation TTShareHelper

+ (TTShareHelper *)shareHelper
{
    static TTShareHelper *mobManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mobManager = [[TTShareHelper alloc] init];
    });
    
    return mobManager;
}

- (void)shareArticleWith:(NewsDetailModel *)model
              industryId:(NSNumber *)industryId
               shareType:(NSString *)type
   currentViewController:(BaseViewController *)currentVC {
    
    self.currentBaseViewController = currentVC;
    self.currentDetailModel = model;

    NSString *contentUrl = [NSString stringWithFormat:@"%@h5/showNews&newsid=%@&inid=%@", SERVER_PATH, model.newsId,industryId];
    __weak typeof (self) weakSelf = self;
    
    __block UIImage *img = [UIImage imageNamed:@"180 Retina HD Home Screen (iOS 7_8).png"];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.imagePic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (image) {
            img = [image imageByScalingProportionallyToSize:CGSizeMake(100, 100)];
        }
        if (!img) {
            
        }
        [weakSelf doSnsShareWorkWithImage:img shareUrl:contentUrl shareType:type];
        
    }];
   

    
}


- (void)doSnsShareWorkWithImage:(UIImage *)image shareUrl:(NSString *)url shareType:(NSString *)type {

  
    
    
    NSString *content = self.currentDetailModel.content;
    NSString *title = self.currentDetailModel.articleName;
    if ([type isEqualToString:UMShareToSina]) {
        
        content = [NSString stringWithFormat:@"商业头条【%@】---来自---%@",self.currentDetailModel.articleName,url];
        
    } else if ([type isEqualToString:UMShareToQQ]) {
        if (title.length > 50) {
            title = [title substringToIndex:50];
        }
        if (content.length > 150) {
            content = [content substringToIndex:150];
        }
        [UMSocialData defaultData].extConfig.title = title;
        [UMSocialData defaultData].extConfig.qqData.url = url;
        
    } else if ([type isEqualToString:UMShareToQzone]) {
        
        if (title.length > 50) {
            title = [title substringToIndex:50];
        }
        content = @"";
        [UMSocialData defaultData].extConfig.title = title;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
    } else if ([type isEqualToString:UMShareToWechatSession]) {
        
        if (title.length > 50) {
            title = [title substringToIndex:50];
        }
        if (content.length > 150) {
            content = [content substringToIndex:150];
        }
        [UMSocialData defaultData].extConfig.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    } else if ([type isEqualToString:UMShareToWechatTimeline]) {
        
        if (title.length > 50) {
            title = [title substringToIndex:50];
        }
        
        content = @"";
        [UMSocialData defaultData].extConfig.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    }
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[type]
                                                        content:content
                                                          image:image
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:self.currentBaseViewController
                                                     completion:^(UMSocialResponseEntity *shareResponse){
                                                         if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                                                             NSLog(@"分享成功！");
                                                         }
                                                     }];
}


@end
