//
//  NewsDetailModel.h
//  BusinessNews
//
//  Created by liufeng on 16/9/1.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "Mantle.h"
#import "BaseCmd.h"
#import "NewsListUnit.h"

@interface NewsDetailModel : BaseCmd<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *newsId;         //新闻id
@property (nonatomic, strong) NSString *articleName;    //新闻标题
@property (nonatomic, strong) NSNumber *websitId;       //网站id
@property (nonatomic, strong) NSNumber *contentId;      //内容id
@property (nonatomic, strong) NSString *sourceUrl;      //新闻源地址
@property (nonatomic, strong) NSString *imagePic;       //新闻图片
@property (nonatomic, strong) NSString *content;        //新闻内容
@property (nonatomic, strong) NSNumber *isTop;          //是否置顶？
@property (nonatomic, strong) NSNumber *publishTime;    //发布时间
@property (nonatomic, strong) NSNumber *crawleTime;     //发布时间new

@property (nonatomic, strong) NSString *websitName;
@property (nonatomic, strong) NSNumber *viewCount;

@end
