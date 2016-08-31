//
//  Publish_Definition.h
//  tranb
//  与产品发布有关的宏定义
//  Created by  SmallTask on 15/6/28.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#ifndef tranb_Publish_Definition_h
#define tranb_Publish_Definition_h

//--8：渠道编号
#define CPId            CPId_Zhy
//#define CPId            CPId_YMT


/*渠道编号；andriod版升级都从9tong.com来下载，所以不需要渠道编号；
 1:appstore,
 2:91助手
 */
#define CPId_APPSTORE           @"1"        //废弃
#define CPId_91STORE            @"2"        //越狱渠道 91
#define CPId_APPSTORE_XIXI917   @"3"        //尚泽 Appstore
#define CPId_TONGBUTUI          @"4"        //越狱渠道 同步推
#define CPId_PP                 @"5"        //越狱渠道 pp 助手
#define CPId_Zhy                @"6"        //主力 Appstore
#define CPId_TONGBUTUI_PRE      @"7"        //预安装渠道 同步推
#define CPId_LISA               @"8"        //lisa 帐号 Appstore
#define CPId_YMT                @"9"        //易鸣堂账号
#define CPId_Zhy_en             @"100"      //英文版 Appstore


//umeng统计的渠道
#define umeng_Channel       @{CPId_APPSTORE: @"",\
CPId_91STORE: @"91store",\
CPId_APPSTORE_XIXI917: @"shangzer",\
CPId_TONGBUTUI: @"tongbutui",\
CPId_PP: @"PP",\
CPId_Zhy:@"zhy135",\
CPId_TONGBUTUI_PRE:@"tongbutui_pre",\
CPId_LISA:@"LISA",\
CPId_YMT:@"YMT",\
CPId_Zhy_en:@"zhy135",\
}

//扣量
#define umeng_leak       @{CPId_TONGBUTUI_PRE:@"tongbutui_pre_L",\
};
//服务器端统计的渠道，和监测升级相关
#define server_Channel       @{CPId_APPSTORE: @"IPhone",\
CPId_91STORE: @"91",\
CPId_APPSTORE_XIXI917: @"IPhone",\
CPId_TONGBUTUI: @"91",\
CPId_PP: @"91",\
CPId_Zhy:@"IPhone",\
CPId_TONGBUTUI_PRE:@"91",\
CPId_LISA:@"IPhone",\
CPId_YMT:@"IPhone",\
CPId_Zhy_en:@"IPhone",\
};
//推送渠道，与bundle ID相关
#define pushServer_Channel   @{CPId_APPSTORE: PushServerTranb,\
CPId_91STORE: PushServerZhy_rmt,\
CPId_APPSTORE_XIXI917: PushServerXIXI917,\
CPId_TONGBUTUI: PushServerZhy_rmt,\
CPId_PP: PushServerZhy_rmt,\
CPId_Zhy:PushServerZhy_rmt,\
CPId_TONGBUTUI_PRE:PushServerZhy_rmt,\
CPId_LISA:PushServerLisa_rmt,\
CPId_YMT:PushServerYMT_rmt,\
CPId_Zhy_en:PushServerZhy_rmt,\
};

#define AppStoreAddressDict   @{CPId_APPSTORE: @"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_91STORE: @"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_APPSTORE_XIXI917: @"https://itunes.apple.com/cn/app/ren-mai-tong-shang-wu-she/id591755543?mt=8",\
CPId_TONGBUTUI: @"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_PP: @"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_Zhy:@"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_TONGBUTUI_PRE:@"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_LISA:@"https://itunes.apple.com/cn/app/ren-mai-tong-gong-qiu-shang/id673654459?mt=8",\
CPId_Zhy_en:@"",\
CPId_YMT:@"https://itunes.apple.com/us/app/ren-mai-tong-fu-zhuang-mian/id1012235369?l=zh&ls=1&mt=8",\
};


#define PushServerTranb         @"0"
#define PushServerXIXI917       @"1"
#define PushServerZhy_rmt       @"2"
#define PushServerLisa_rmt      @"3"
#define PushServerYMT_rmt       @"4"
//4 zhy_rmzz
//5 lisa_rmzz



#pragma mark -

#define SERVER_PATH4TEST [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

#define SOCKET_ENABLE               YES
//socket连接失败后，再次重试的间隔时间，单位:秒
#define SOCKET_RETRY_SECOND         5
//socket连接超时的时间，单位：秒；
#define SOCKET_TIMEOUT_SECOND       3*60
//GPS定位启动的间隔，1小时内不再重复启动
#define GPS_TIMEOUT_SECOND          60*60


//afnetworking 之外的 server
//#define SERVER_PATH_URL  @"www.BizbookApp.com"

//#define SERVER_PATH_URL  @"api.9tong.com"           //正式的生产服务器
//#define SERVER_PATH_URL  @"192.168.254.120"         // 测试服务器
//#define SERVER_PATH_URL  @"140.206.176.238:18057"    //192.168.254.120测试服务器的公网映射地址
//#define SERVER_PATH_URL @"139.196.14.165:18057"  //正式环境地址
//#define SERVER_PATH_URL  @"api.9tong.com"
//#define SERVER_PATH_URL  @"192.168.254.120"         // 测试服务器
//#define SERVER_PATH_URL  @"192.168.254.50:8080/RMT"    // 易德军
//#define SERVER_PATH_URL  @"58.247.112.82:9980"      // 德军电脑映射的外网服务器
//#define SERVER_PATH_URL  @"61.129.52.141:18057"       // 公网
//#define SERVER_PATH_URL  @"192.168.254.54:8080/RMT"       // 宋同玉
//#define SERVER_PATH_URL  @"192.168.254.52:8080/RMT"       // 胥攀
#define SERVER_PATH_URL  @"head.9tong.com"    //商业头条


#define S_SERVER_PATH_URL  @"s1.9tong.com"            // 静态资源文件的首地址

#define H_SERVER_PATH_URL  @"www.9tong.com"           //分享使用地址

#define JMESSAGE_APPKEY_TEST    @"dff58baa0189246645668dde"  //Jpush测试帐号app key
#define JMESSAGE_APPKEY_RELEASE @"ce6e8aee881ae9689975e3b8"  //Jpush生产帐号app key
//#define JMSSAGE_APPKEY      @"dff58baa0189246645668dde"
#define JMSSAGE_APPKEY JMESSAGE_APPKEY_TEST

/*
 1供应链身份列表
 2保存工作经历
 3保存profile 。
 
 4查看profile
 5注册第二步
 6修改注册帐号第二部
 7修改注册帐号第一步
 */
//#define SERVER_PATH_URL @"192.168.254.223"      // 魏慧

//#define SERVER_PATH_DOWNLOAD @"http://www.9tong.com/"


//人脉通公网
#define SERVER_PATH [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

//会议系统的服务器入口地址165
#define SERVER_PATH_MEETING [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]



#define SponsorLogoDownloadUrl [NSString stringWithFormat:@"http://%@/upload",SERVER_PATH_URL]


//获取系统推荐联系人服务接口
#define SERVER_PATH_LISTRECOMMENT  [NSString stringWithFormat:@"http://%@/user/listRecommend.do",SERVER_PATH_URL]


//上传联系人接口,增量更新，下载联系人
#define SERVER_PATH_UPLOAD_CONTACT [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]


//私信接口
#define SERVER_PATH_IM [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]


////私信图片接口
//#define SERVER_PATH_IM_IMAGES [NSString stringWithFormat:@"http://%@/upload/message/",SERVER_PATH_URL]

//公司群组
#define SERVER_PATH_LIST_COMPANY [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

//用户信息管理
#define SERVER_PATH_USER_INFO [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]


//用户头像获取接口
#define SERVER_PATH_USER_ICON [NSString stringWithFormat:@"http://%@/",S_SERVER_PATH_URL]

//联系人信息管理
#define SERVER_PATH_CONTACT_INFO [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

////上传联系人头像
//#define SERVER_PATH_UPLOAD_CONTACTS_IMAGE [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]
//
////上传用户头像
//#define SERVER_PATH_UPLOAD_USER_IMAGE [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]
//
////下载联系人头像
//#define SERVER_PATH_DOWNLOAD_CONTACTS_IMAGE [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]
//
////下载用户头像
//#define SERVER_PATH_DOWNLOAD_USER_IMAGE [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]
//
////签到图片
//#define SERVER_PATH_DOWNLOAD_CHECKIN_IMAGE [NSString stringWithFormat:@"http://%@/upload/checkin/",SERVER_PATH_URL]

//交换名片
#define SERVER_PATH_EXCHANGE_CARD  [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

//上传名片图片
#define SERVER_PATH_CARDIMG_UPLOAD  [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

//名片夹同步
#define SERVER_PATH_OCR             [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]


//time line
#define SERVER_PATH_TIME_LINE       [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

//商业人脉
#define SERVER_PATH_COMMERCIAL      [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]


//意见反馈
#define SERVER_PATH_FEEDBACK      [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]


#define SERVER_PATH_ICON_IMAGE_URL_STR @"%@contacts/downloadContactsImage.do?UID=%d&typeOf=2"

#define SERVER_PATH_CARDIMG_BASE    [NSString stringWithFormat:@"http://%@/",S_SERVER_PATH_URL]
#define SERVER_PATH_VERSION_CHECK   [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]
#define SERVER_PATH_LBS             [NSString stringWithFormat:@"http://%@/",SERVER_PATH_URL]

////测试
////通知图片的下载地址
//#define Notice_Img_Path  @"http://img.sucai.redocn.com/attachments/images/201007/20100719/20100718_0dec750524cbe40e8e00RllLcN6cOWer.jpg"
////通知图片的点击跳转html地址
//#define Notice_Html_Path @"http://www.baidu.com"

//抽奖,已测
#define SERVER_PATH_LOTTO [NSString stringWithFormat:@"http://%@/h5/lotto_ios.jsp",SERVER_PATH_URL]
//推荐广告,已测
#define SERVER_PATH_RMT_AD [NSString stringWithFormat:@"http://%@/9tong_AD.jsp",SERVER_PATH_URL]

//如何发布优质商品 - 上传商品前提示
#define SERVER_PATH_PUSHPRODUCT [NSString stringWithFormat:@"http://%@/jsp/pushProduct.jsp",SERVER_PATH_URL]

//推送详情 - 商品详情提示
#define SERVER_PATH_PUSHPRODUCT_DETAIL [NSString stringWithFormat:@"http://%@/jsp/pushProductDetail.jsp",SERVER_PATH_URL]

//推广说明 - 首页商品详情提示
#define SERVER_PATH_PUSHPRODUCT_DESC [NSString stringWithFormat:@"http://%@/jsp/pushProductDesc.jsp",SERVER_PATH_URL]

//积分,已测
#define SERVER_PATH_INTEGRALLIST [NSString stringWithFormat:@"http://%@/jsp/integrallist.jsp",SERVER_PATH_URL]

#pragma mark -
#define SNS_SHARE_IMG_AFTER_LOGIN S_SERVER_PATH_RMT_SMALL_ICON

#pragma mark - 静态资源调用集

//推荐图片,已测
#define S_SERVER_PATH_RMT_RECOMMEND_IMAGE [NSString stringWithFormat:@"http://%@/images/f1.png",S_SERVER_PATH_URL]

//默认小logo,已测
#define S_SERVER_PATH_RMT_SMALL_ICON [NSString stringWithFormat:@"http://%@/images/rmt_small.png",S_SERVER_PATH_URL]

//人脉通用户隐私策略
#define S_SERVER_PATH_PRIVACY [NSString stringWithFormat:@"http://%@/assets/rmt/privacy.html",S_SERVER_PATH_URL]

//人脉通服务协议
#define S_SERVER_PATH_SERVICEAGREEMENT [NSString stringWithFormat:@"http://%@/assets/rmt/serviceAgreement.html",S_SERVER_PATH_URL]

//通知图片的下载地址
#define Notice_Img_Path [NSString stringWithFormat:@"http://%@/notice_pic/notice.jpg",S_SERVER_PATH_URL]

//通知图片的点击跳转html地址
#define Notice_Html_Path [NSString stringWithFormat:@"http://%@/notice_pic/notice.html",S_SERVER_PATH_URL]

//版本号
#define kVersion_BNT [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


#endif
