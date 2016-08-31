/*
 *  Definition.h
 *  E-Magazine
 *
 *  Created by Yang Wei on 09-12-3.
 *  Copyright 2009 Tapatalk. All rights reserved.
 *
 */



#import "ErrorManager.h"
#import "StringTools.h"
#import "NSObject+JSON.h"

//#import "UIFactory.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

////////////////////////////E////////////////////////////////////
//修改 CFBundleDisplayName="人脉通En";
//--1：调试模式--
#define DEBUG_VERSION           YES

/**
 开启APNS测试模式，当模式开启时，可以在APP内自行模拟收到一条APNS消息时的处理
 目的：模拟APP在收到APNS的界面跳转行为等是否正确；
 当DEBUG_VERSION为NO时，本变量不生效
 */
#define APNS_SIMULATE_ENABLE    [USER boolForKey:@"APNS_SIMULATE_ENABLE"]

//测试名片活动
#define TEST_NAMECARD           NO



/*
 *创建日志输出方法
 */
#ifdef DEBUG

static const int ddLogLevel = LOG_LEVEL_VERBOSE;//LOG_LEVEL_OFF;////;//

#define SLOG(frmt, ...)    DDLogInfo((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)

//#define SLOG(frmt, ...)  DDLogInfo((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
//#define SLOGE(frmt, ...) DDLogError((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__)
//#define SLOGW(frmt, ...) DDLogWarn((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
//#define SLOGI(frmt, ...) DDLogInfo((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
//#define SLOGD(frmt, ...) DDLogDebug((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__)
//#define SLOGV(frmt, ...) DDLogVerbose((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,     ##__VA_ARGS__)
//

#else

static const int ddLogLevel = LOG_LEVEL_OFF;
#define SLOG(frmt, ...)
//#define SLOGE(frmt, ...)
//#define SLOGW(frmt, ...)
//#define SLOGI(frmt, ...)
//#define SLOGD(frmt, ...)
//#define SLOGV(frmt, ...)

#endif

#define IMLogInfo(frmt, ...)        DDLogInfo((@"-----IM----- %s-%d:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
#define IMLogError(frmt, ...)       DDLogError((@"*****IM***** %s-%d:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)

//#define IMLogInfo(frmt, ...)     NSLog((@"-----IM----- " frmt), ##__VA_ARGS__)
//#define IMLogError(frmt, ...)     NSLog((@"*****IM***** " frmt), ##__VA_ARGS__)

//非会员人脉上限
#define CONTACTS_COUNT   1000
//发布改1000
//--2：设置界面语言的版本；--
/*
 a.如果发布的是纯净语言版，LANGUAGE表示APP的绘制语言；
 b.如果发布的是自动适配手机操作系统语言的版本（国际化版本）:
 当手机操作系统的语言是APP中未进行国家化处理的语言时，APP会强制界面使用LANGUAGE所指定的语言作为界面显示语言；
 */

#define LANGUAGE LANGUAGE_CN

//--3：是否打开纯净语言版开关
/*
 如果要发布纯净语言版本，则必须打开本参数 ；
 即设置：LANGUAGE_CLEAN_FIT_ON = YES
 在纯净语言版模式下，无论手机操作系统使用何种语言，APP中都是显示中文；
 
 当发布纯净语言版本的APP时，请复制项目发布；
 发布前，只保留与指定语言有关的资源，其余资源及相关设置一律删除；
 （具体操作参见文档docs/配置多语言.rtf）
 */
#define LANGUAGE_CLEAN_FIT_ON         YES
//中文发布 LANGUAGE_CLEAN_FIT_ON         YES

//--4：自动适配用户手机系统的语言；
/*
 a.当LANGUAGE_FIT_ON = YES 时，本参数无效；
 
 b.当LANGUAGE_FIT_ON = NO 时：
 b.1 当LANGUAGE_AUTO_FIT = YES 时
 如果App中不包括用户手机系统默认语言的资源，则使用LANGUAGE指定的语言作为默认语言；
 
 b.2 当LANGUAGE_AUTO_FIT = NO
 强制APP必须使用指定的语言，而不管用户的手机系统使用的是何种语言；
 !!!重要建议：如果要使用这种发布模式，建议使用纯净语言版的发布模式，干净卫生；
 */
#define LANGUAGE_AUTO_FIT   NO
//中文发布 LANGUAGE_AUTO_FIT   NO

//--5：设置plist文件里，项目默认语言（决定了启动时使用哪一个plist文件）
//配置plist文件里，Localization native development region 为对应的语言；en,cn,ja

//--6：版本号，用于升级检测
#define VERSION_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kVersionBuild [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//--7：版本号：用于界面显示 (被方法  [self appVersion] 替代了)
//#define APP_VERSION @"V1.500"




//--9:友盟统计后台设置
#define APPKEY_UMENG_CN     @"4fa894bf52701515b4000012"
#define APPKEY_UMENG_EN     @"52ae783756240b08b01e7296"


//小秘书的uid
#define LITTER_SECRETARY_UID  2228595
#define LITTER_SECRETARY_UID2  10545111

//--other:其他检查
//检查http服务器IP配置
//检查Socket服务器IP配置

//用于标记和定位Bizbook V1.1.0版的判断；当服务器端准备好后，需要将所有IS_BIZBOOK_V1_1_0的地方都清除掉；
#define IS_BIZBOOK_V1_1_0   NO

////////////////////////////////////////////////////////////////


#define IOS7_SDK_AVAILABLE ([[[UIDevice currentDevice] systemVersion] intValue] >= 7)

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
#define WINDOWS [[UIApplication sharedApplication].windows objectAtIndex:0]


//用于公司局域网内的测试
#define TEST_IN_LOCAL_NETWORK   NO

//是否显示广告
#define IsShowAdBanner      YES
#define AdBannerWidth       320
#define AdBannerHeight      50
#define IsTimelineBannerShown YES

#define LANGUAGE_CN     @"zh-Hans"
#define LANGUAGE_EN     @"en"
#define LANGUAGE_JAPAN  @"ja"

#define COUNTRY_ID_CN       1
#define COUNTRY_ID_JP       2
#define COUNTRY_ID_USA      3


//是否开放名片活动
#define IsNameCardActivityAvailable     YES


//手机操作系统的语言
#define LANGUAGE_CURRENT [(NSMutableArray*)[USER objectForKey:@"AppleLanguages"] objectAtIndex:0]

#define IsChineseVersion    YES
#define IsJapanVersion      NO
#define IsEnglishVersion    NO

/*
 #if LANGUAGE_CLEAN_FIT_ON
 //使用APP强制规定的语言来作为判断依据；
 #define IsChineseVersion [LANGUAGE isEqualToString:LANGUAGE_CN]
 #define IsJapanVersion   [LANGUAGE isEqualToString:LANGUAGE_JAPAN]
 #define IsEnglishVersion [LANGUAGE isEqualToString:LANGUAGE_EN]
 #else
 //使用手机系统语言来作为判断依据
 #define IsChineseVersion [LANGUAGE_CURRENT isEqualToString:LANGUAGE_CN]
 #define IsJapanVersion   [LANGUAGE_CURRENT isEqualToString:LANGUAGE_JAPAN]
 #define IsEnglishVersion [LANGUAGE_CURRENT isEqualToString:LANGUAGE_EN]
 #endif
 */


//应用编号;7表示iPhone版的人脉通
#define APPID 7

#define MaxOpcode 26
#define MaxOpcodeShareSource  5
//用来屏蔽新增加的动态消息类型

//屏蔽评论动态的类型
#define MaxOpcodeTimeLineTimelineComment 4
//话题分享的动态
#define MaxOpcodeTimeLineArticleShare 4
//群组动态
#define MaxOpcodetypeGroupTimeLineGtype 4
//赞
#define MaxOpcodTimeLinePraiseGtype 4
//随机出现广告条
#define MaxOpcodTimeLineRecommendInviteUserType 3

//在我的好友界面中，当好友数量大于100人时，显示行业面板
#define ContactsCountLimitWhenShowIndustryPanel 100


/**上传手机通讯录，新版功能开关*/
#define UPLOAD_MOBILE_CONTACTS_NEW_VERSION YES

#pragma mark -  social
//社交网站接入开关
/**微博登录相关；
 0:不显示微博帐号登录；
 1:显示微博帐号登录；
 */
#define SOCIAL_SWITCH      0


/**V1.11版的两个新功能是否可以使用；
 a.动态列表里：参加会议制作一个新的展现方式；
 b.动态列表里：名片交换制作一个新的展现方式；
 
 0:这两个功能不能使用；
 1:这两个功能可以使用；
 */
#define VERSION_Test_1_2   1

#define VERSION_TEST_1_2_2 1

//#define SWITCH_IS_LINKEDIN_ON   1

//#define WECHAT_APPID  @"wx4a5f24afbfee1e60"
//#define WECHAT_SECRET @"db9099707b020b6c6cbc29a65bc24eda"


//#ifndef kWBSDKDemoAppSecret
//#define kWBSDKDemoAppSecret			@"50deed0f096821dffab1ce1f8e114449"		//REPLACE ME    3acf036f3171f044b884da0d099ca0fc
//#endif
//#ifndef kWBSDKDemoAppKey
//#define kWBSDKDemoAppKey			@"777322123"		//REPLACE ME     3816162523
//#endif
//#define WBCallBackUrl               @"http://61.129.52.136:8080/callback.jsp"

//#define LinkedInConsumerKey  @"dfmmyspsemia"
//#define LinkedInConsumerSecret  @"rYlCCvc71TMrIKgc"
////#define LinkedInConsumerKey_en  @"75pprho50cp9y2"
//#define LinkedInConsumerSecret_en  @"dbfEKlwGIcxQaTna"

//NSLog(@"%s NSCache supported", __FUNCTION__);  推荐使用这个 __func__

//是否允许上传联系人
#define CAN_UPLOAD_CONTACTS YES

#define HAS_USER_REGIST_DEVICE @"HAS_USER_REGIST_DEVICE"

#define nls(a)(NSLocalizedString(a,@""))

//format server string
#define fss(a,l) [StringTools GetServerString:a limitLen:l]

#define PI 3.1415926535f

#define TRIM stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
#define TRIM_NewLine stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]

#define JPEGQULITY 0.7

#define JPEGQULITY_FOR_DISPLAY 0.7

#define JPEGQULITY_FOR_OCR     0.1

#define USER [NSUserDefaults standardUserDefaults]

#define TRANB (tranbAppDelegate*)[[UIApplication sharedApplication] delegate]


//客服电话
#define SERVICE_TEL  @"4009905190"
//客服电话（用来显示在UI上）
#define SERCICE_TEL_UI @"400-990-5190"

//专属客服电话
#define SERVICE_SUPER_TEL  @"4009909872"
#define SERCICE_WORKTIME_UI @"工作日 9：30-18：30"


#define ARTICLE_LIST_COUNT_IN_PAGE 20

#define DOWNLOAD_CONTACTS_ITEM_COUNT_IN_PAGE_WIFI  15
#define DOWNLOAD_CONTACTS_ITEM_COUNT_IN_PAGE_GPRS  10


//每次上传通讯录的条数
#define UPLOAD_ITEMCOUNT_PERTIME_WIFI    20
#define UPLOAD_ITEMCOUNT_PERTIME_GPRS    10
//每次下载名片的条数
#define DOWNLOAD_CARD_COUNT_WIFI        20
#define DOWNLOAD_CARD_COUNT_GPRS        10

//#define kOAuthConsumerKey				@"777322123"		//REPLACE ME
//#define kOAuthConsumerSecret			@"50deed0f096821dffab1ce1f8e114449"		//REPLACE ME

#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101


#define IsDeckShow  YES



//程序所有上传格式
#define UPLOAD_IMAGE_FORMAT_JPG @"jpg"

#define Member_Icon_Placeholer  @"               "

#define NetState_Rest       0
#define NetState_Connecting 1
#define NetState_Connected  2
#define NetState_Error      3
#define NetState_ShutDown   4

#pragma mark -
//成功
#define ERR_SUCCESS  0
//网络故障
#define ERR_NETWORK	-1
//注册失败
#define ERR_REG		-2
//登录失败
#define ERR_LOGIN	-3
//地址本
#define ERR_ADDRESSBOOK -4

//sns分享内容重复
#define ERR_REPEAT_SNS_CONTENT -501
#define ERR_SNS_BIND_REPEAT    -502
#define ERR_SNS_AUTH_CANCEL    -503
#define ERR_SNS_AUTH_REFUSED    -504

//未定义的错误
#define ERR_UNDEFINED       -5002

#pragma mark -


#pragma mark -

#pragma mark - USERDEFAULT
#define U_DictHasAddToCommercial(uid) [NSString stringWithFormat:@"U_DictHasAddToCommercial%lld",(uid)]


#pragma mark -

#define ContentTagIsPhoneTag(ContentTag)  (ContentTag==TAG_ROW_Mobile || ContentTag==TAG_ROW_TEL_Office || ContentTag==TAG_ROW_TEL_Home || ContentTag==TAG_ROW_FAX || ContentTag==TAG_ROW_TEL_Other1 || ContentTag==TAG_ROW_TEL_Other2 || ContentTag==TAG_ROW_TEL_Other3)

#define ContentTagIsEmailTag(ContentTag) (ContentTag==TAG_ROW_EMAIL_1 || ContentTag==TAG_ROW_EMAIL_2 || ContentTag==TAG_ROW_EMAIL_3)


#define TAG_UV_TOP              100
#define TAG_UV_BASIC_INFO       101
#define TAG_UV_ARROW_IN_BASIC_INFO  102
#define TAG_UV_BASIC_INFO_BUTTON 103


//NSUserDefault
#define UserDefault_TimeLineCash        @"userdefault_TimeLineCash"
#define UserDefault_CardUnReadCount     @"tab_CardUnReadCount"
#define UserDefault_CardRequestCount    @"tab_CardRequestCount"
#define UserDefault_SocialAccount4Regist    @"SocialAccount4Regist"
#define UserDefault_SocialRegistType    @"SocialRegistType"
#define UserDefault_LinkedInInfo        @"LinkedInInfoCash"
#define UserDefault_SinaPublicTokenTime   @"SinaPublicTokenTime"
#define UserDefault_LinkedInPublicTokenTime   @"LinkedInPublicTokenTime"
#define UserDefault_OpportunityRefreshTime      @"OpportunityRefreshTime"

#define UserDefault_LoginSussicSocialMethod     @"LoginSussicSocialMethod"
#define UserDefault_LoginSussicSocialId         @"LoginSussicSocialId"

//记录用户绑定成功的手机号
#define UserDefault_HasVerityPhoneNumber @"UserDefaultNameHasVerityPhoneNumber"

//激活短信验证次数
#define SignUpActive_VerifyCodeInputTimes @"ActiveCodeInputTimes"

#define COOKIE_HEADER @"Set-Cookie"

#define TIP_MESSAGE_TITLE   @""
#define TIP_SYSTEM_INIT     NSLocalizedString(@"正在检测网络，请稍候", @"")
//#define TIP_USERINFO_NOT_COMPLETE_WHEN_EXCHANGE_CARD @"请完善你的公司名称和职位信息，否则将无法交换名片"
#define TIP_USERINFO_NOT_COMPLETE_WHEN_EXCHANGE_CARD NSLocalizedString(@"人脉通是一个实名制商务社交网络，当你如实填写你的姓名、公司名称、职位、联络方式的时候，你可能会收到更多人脉拓展和信息交换的机会。建议你填写你的更多信息。", @"")
#define TIP_USERINFO_NOT_COMPLETE_WHEN_ADD2COMERCIAL NSLocalizedString(@"请完善你的公司名称和职位信息，否则将无法添加商业人脉", @"")
#define TIP_ADDCOMMERCIAL_SUCCESS NSLocalizedString(@"联系人已成功添加至商业人脉", @"")
#define TIP_NETWORK_ERROR @"网络状态不佳"
#define TIP_NODATA  @"没有找到合适的数据"


#pragma mark - 长度限制
#define lenChat 300
#define TagRemove   22881

#define MaxContentHeighInGroupTopicList 90

#define COMPANY_TYPE @[@"外资（欧美）",@"外资（非欧美）",@"合资（欧美）",@"合资（非欧美）",@"国企",@"民营公司",@"外企代表处",@"政府机关",@"事业单位",@"非盈利机构",@"其他性质"]

#define COMPANY_SIZE @[@"少于50人",@"50-149人",@"150-499人",@"500-999人",@"1000-4999人",@"5000-9999人",@"10000人以上"]

#define UNIT_NAME_ARRAY @[@"件",@"个",@"台",@"吨",@"盒",@"套",@"公斤",@"瓶",@"条",@"双",@"包",@"米",@"箱",@"单",@"张",@"辆",@"部",@"千克",@"袋",@"只",@"支",@"把",@"桶",@"平方米",@"块",@"片",@"根",@"卷",@"对",@"本",@"株",@"罐",@"颗",@"立方",@"款",@"顶",@"组",@"打",@"幅",@"头",@"克",@"座",@"盏",@"票",@"粒",@"码",@"枚",@"公升",@"架",@"盆",@"课",@"节",@"升",@"平方英尺",@"卡",@"毫升",@"尊",@"平方市尺",@"具",@"束",@"面",@"吊",@"厘米",@"平方厘米",@"毫米"]
#define UNIT_NAME_ARRAY_MIANLIAO @[@"米",@"码",@"张",@"千克"]

//#define CGRectWaitingPanel CGRectMake(70, 100, 195, 113)

#define SOCIAL_REGISTER_PASSWORD    @"000000" //六位随即密码


#define SplashCountNormal      4
#define SplashCountUpdate      3
#define SplashCountNormal_EN   3
#define SplashCountUpdate_EN   2

#define MeetingCheckInUserListTable_AlertNoProfileTips  99


#pragma mark - sns
typedef void(^snsAuthBlock)(NSString *snsId,NSError *error);
typedef void(^unBindSnsBlock)(NSError *error);
typedef void(^shareSnsBlock)(NSError *error);
typedef void(^snsAvatarBlock)(NSString *imgUrl,NSError *error);

#pragma mark - 支付回调
typedef void (^PaymentSuccessBlock)(id userInfo);
typedef void (^PaymentFailedBlock)();


//消除编译警告
#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")

#pragma mark - 
#define IMG_PLACEHOLDER_PRODUCT [UIImage imageNamed:@"product_image_default"]
#define IMG_PLACEHOLDER_PURCHASE_ICON [UIImage imageNamed:@"img-default-160x160"]

