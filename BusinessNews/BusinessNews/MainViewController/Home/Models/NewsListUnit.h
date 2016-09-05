//
//  NewsLsitCmd.h
//  BusinessNews
//
//  Created by liufeng on 16/9/2.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "BaseCmd.h"

@interface NewsListUnit : BaseCmd

@property (nonatomic, strong) NSNumber *newsId;         //新闻id
@property (nonatomic, strong) NSNumber *viewCount;      //浏览次数
@property (nonatomic, strong) NSString *articleName;    //新闻标题
@property (nonatomic, strong) NSNumber *websitId;       //网站id
@property (nonatomic, strong) NSNumber *contentId;      //内容id
@property (nonatomic, strong) NSNumber *crawleTime;     //
@property (nonatomic, strong) NSString *imagePic;       //新闻图片
@property (nonatomic, strong) NSString *introduction;   //
@property (nonatomic, strong) NSNumber *publishTime;    //发布时间
@property (nonatomic, strong) NSString *praiseCount;
@property (nonatomic, strong) NSNumber *industryId;
@property (nonatomic, strong) NSString *webSitName;
@property (nonatomic, strong) NSString *webSitLogo;
/**
 "articleName": "1299元魅蓝U20开箱图赏：颜值不一般",
 "contentid": "8782183",
 "crawleTime": 1472572758542,
 "hits": 2342,
 "id": "968994",
 "introduction": "日前，魅族悄然发布了两款魅蓝新机，分别是U10、U20。 两款魅族新机均采用双面玻璃 金属边框的设计，前者5寸，后者是5.5寸，有白、黑、金和玫瑰金可选。我们拿到的是白色版U20，下面来看图赏",
 "praiseCount": "0",
 "publishTime": "20160830",
 "webSitId": 8
 */
@end
