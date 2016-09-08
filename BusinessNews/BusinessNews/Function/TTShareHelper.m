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
               shareType:(SSDKPlatformType)type
   currentViewController:(BaseViewController *)currentVC {
    
    switch (type) {
        case SSDKPlatformTypeSinaWeibo:
            
            break;
        case SSDKPlatformSubTypeQZone:
            
            break;
        case SSDKPlatformSubTypeQQFriend:
            
            break;
        case SSDKPlatformSubTypeWechatSession:
            
            break;
        case SSDKPlatformSubTypeWechatTimeline:
            
            break;
        default:
            break;
    }
    NSString *contentUrl = [NSString stringWithFormat:@"%@h5/showNews&newsid=%@&inid=%@", SERVER_PATH, model.newsId,industryId];
    __weak typeof (self) weakSelf = self;
    
    __block UIImage *img = [UIImage imageNamed:@"rmtShareIntroduce.png"];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.imagePic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (image) {
            img = [image imageByScalingProportionallyToSize:CGSizeMake(100, 100)];
        }
        
        [weakSelf doSnsShareWorkWithImage:img shareContent:model.content shareUrl:contentUrl shareTitle:model.articleName shareType:type];
        
    }];
    
}


- (void)doSnsShareWorkWithImage:(UIImage *)image shareContent:(NSString *)shareContent shareUrl:(NSString *)url shareTitle:(NSString *)title shareType:(SSDKPlatformType)type {

    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:shareContent
                                     images:image //传入要分享的图片
                                        url:[NSURL URLWithString:shareContent]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    //进行分享
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
         if (error) {
             //show error
         } else {
             //show share success
         }
     }];
    
}

@end
