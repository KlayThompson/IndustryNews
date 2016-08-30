//
//  ENUM_Definition.h
//  tranb
//
//  Created by Smalltask on 15/6/23.
//  Copyright (c) 2015年 cmf. All rights reserved.
//

#ifndef tranb_ENUM_Definition_h
#define tranb_ENUM_Definition_h

#pragma mark 用户基本信息定义
#define TAG_ROW_Mobile              0
#define TAG_ROW_TEL_Office          1
#define TAG_ROW_TEL_Home            2
#define TAG_ROW_FAX                 3
#define TAG_ROW_TEL_Other1          4
#define TAG_ROW_TEL_Other2          5
#define TAG_ROW_TEL_Other3          6
#define TAG_ROW_EMAIL_1             7
#define TAG_ROW_EMAIL_2             8
#define TAG_ROW_EMAIL_3             9
#define TAG_ROW_URL                 10
#define TAG_ROW_ADDRESS             11
#define TAG_ROW_BIRTHDAY            12
#define TAG_ROW_NAME_CHINESE        13
#define TAG_ROW_NAME_ENGLISH        14
#define TAG_ROW_COMPANY             15
#define TAG_ROW_DEPARTMENT          16
#define TAG_ROW_JOB                 17
#define TAG_ROW_INDUSTRY            18
#define TAG_ROW_INTRODUCE           19
#define TAG_ROW_COUNTRY             20
#define TAG_ROW_CITY                21
#define TAG_ROW_COMPANYADDRESS      22
#define TAG_ROW_QQ                  23
#define TAG_ROW_MSN                 24
#define TAG_ROW_ADD_PHONE           25
#define TAG_ROW_ADD_EMAIL           26
#define TAG_ROW_ADD_OTHER_INFO      32
//公司规模，例如：10-100人
#define TAG_ROW_COMPANY_SIZE        27
//公司性质,例如：外企，国企，
#define TAG_ROW_COMPANY_TYPE        28
//公司成员,100位成员
#define TAG_ROW_COMPANY_MEMBER      29
//邮政编码
#define TAG_ROW_ZIPCODE             30
//用于名片夹：保存名片式，是否自动发送邀请短信
#define TAG_ROW_SEND_INVITE_SMS     31


#pragma mark - 联系人信息相关

typedef enum{
    
    UserListType_Industry = 0,   ///行业人脉
    UserListType_Location,    //附近人脉
    UserListType_NewCast,     //最新加入
    UserListType_Visitors,    //谁看过我的档案
    UserListType_Recommend,   //可能认识
    UserListType_Recommend_New,  //推荐人脉
    UserListType_GroupMembers,
    UserListType_EventMembers,
    UserListType_CompanyMembers,
    UserListType_Search,
    UserListType_NewContacts,   //名片交换请求列表中， 添加我为好友的记录
    UserListType_SDRVisitors,    //谁看过我的供求
    UserListType_ProductVisitors,    //谁看过我的商品
    UserListType_PraiseUserList,//赞过的用户列表；
    UserListType_RenMai         // 合并过的人脉
} UserListType;


#define SECTION_TYPE_BASIC_INFO     0
#define SECTION_TYPE_JOB_INFO       1
#define SECTION_TYPE_WORKEXP_INFO   2
#define SECTION_TYPE_EDUCATION      3
#define SECTION_TYPE_OTHER_INFO     4
#define SECTION_TYPE_SOCIAL_INFO    5
#define SECTION_TYPE_SUPPLY         6
#define SECTION_TYPE_DAILY_STATUS   7
#define SECTION_TYPE_HEAD           8
#define SECTION_TYPE_BIND_SOCIAL    9
#define SECTION_TYPE_COMPANY_GROUP  10
#define SECTION_TYPE_PRODUCT        11

#define TAG_ROW_LABEL_TITLE 100
#define TAG_ROW_LABEL_VALUE 101
#define TAG_ROW_LABEL_DETAIL 103
#define TAG_ROW_MAP_ICON    102
#define TAG_USERPROFILE_AVATAR_IMAGEVIEW    200

#pragma mark - 名片相关
#define TAG_CardResultListTable_name  101
#define TAG_CardResultListTable_image 102
#define TAG_CardResultListTable_job   103
#define TAG_CardResultListTable_company   104
#define TAG_CardResultListTable_state   105
#define TAG_CardResultListTable_state_add2commerail   106
#define TAG_CardResultListTable_LineBg  107
#define TAG_CardResultListTable_ReTry   108
#define TAG_CARDRreultListTable_Icon    109

#pragma mark - 场景
typedef NS_ENUM(NSInteger,SCENE_ID) {
    //未定义
    SCENE_UNDEFINED                 = 0,
    
    //人脉模块界面 －抽象界面－只要是会议模块下的界面都可以用这个值，类似继承
    SCENE_CONTACTS                  = 1,
    //人脉－联系人列表
    SCENE_CONTACTS_CONTACTSLIST     = 2,
    //人脉－智能拓展
    SCENE_CONTACTS_ADVANCE          = 3,
    //人脉－公司群组
    SCENE_CONTACTS_COMPANY_GROUP    = 4,
    
    //会议活动模块－抽象界面－只要是会议模块下的界面都可以用这个值，类似继承
    SCENE_MEETING                   = 5,
    //大展会界面
    SCENE_MEETING_LIST              = 6,
    //社交活动界面
    SCENE_SOCIAL_LIST               = 7,
    //谁层参与
    SCENE_WHO_HAS_ATTEND            = 8,
    //朋友动态
    SCENE_FRIEND_STATUS             = 9,
    //商业人脉列表
    SCENE_COMMERCIAL_LIST           = 10,
    //竞标信息
    SCENE_BID_INFO                  = 11,
    //商品推送-->已经推送过的商品列表界面
    SCENE_PROMOTED_PRODUCT          = 12,
    //产品编辑界面
    SCENE_PRODUCT_PROFILE           = 13,
    //我要卖首页
    SCENE_MY_SALES_HOME             = 14,
    //商品profile,用于在自己竞标时显示商品信息
    SCENE_PRODUCT_BID               = 15,
    //系统消息
    SCENE_SYSTEM_NOTIFICATION       = 16,
    //tranb主界面
    SCENE_TRANB_MAIN                = 17,
    //动态列表-->动态详情页
    SCENE_TIMELINE_PROFILE          = 18,
    //动态列表（泛指所有类型的动态列表）v1.680加入，暂时还没有被使用过
    SCENE_TIMELINE_LIST_BASE        = 19,
    //首页->行业动态
    SCENE_TIMELINE_TRADE_LIST       = 20,
    //首页->人脉动态
    SCENE_TIMELINE_ALLFRIENDS_LIST  = 21,
    //发布采购V1.70
    SCENE_NEW_EDIT_PURCHASE_170     = 22,
    //发布商品v1.70
    SCENE_NEW_PRODUCT_170           = 23,
    //群聊－>入群请求审核列表 1.720
    SCENE_GROUP_CHAT_AUDIT_LIST_172 = 24,
    //商品详情 V1.723
    SCENE_PRODUCT_PROFILE_1723      = 25,
    
};


#pragma mark - 其他

typedef enum
{
    typeContactsNewsRemoveCardRequest=0,
    typeContactsNewsRemoveRecommend,
}typeContactsNewsRemove;

typedef enum
{
    TypePurchaseListViewControllerMy = 0,
    TypePurchaseListViewControllerCityIndustry,
    TypePurchaseListViewControllerCityIndustryFilterTop,
}TypePurchaseListViewController;



typedef enum
{
    typeSDRPRecommendWeekly = 0,
    typeSDRPRecommendVIP = 1,
}typeSDRPRecommend;

typedef enum {
    PurchaseTypeAliPay     = 0,  //支付宝支付
    PurchaseTypeWeChat = 1,      //微信支付
    PurchaseTypeIAP = 2,         //iap支付
} PurchaseTypeInRMT;

typedef enum
{
    backCodeSendMessageSuccess=0,
    backCodeSendMessageError=1,
    backCodeSendMessageIsNotMember=2,
    backCodeSendMessageIsMemberLeftNoSuperMessage=3,
    backCodeSendMessageIsMemberFriendDeleteCurrent=4,
}backCodeSendMessage;

//一个付款条目的类型，如：邀请好友获得7天会员资格，并不需要真实的付款；而购买1个月会员资格，则需要真实付款；
typedef enum
{
    PaymentItemType_payMoney = 0,
    PaymentItemType_Invite = 1,
}PaymentItemType;

// 支付方式
typedef NS_ENUM(NSInteger, PaymentType) {
    PaymentType_Alipay = 1,                     // 支付宝
    PaymentType_WeChat = 2,                     // 微信支付
    PaymentType_UnionPay = 3,                   // 银联支付
};

// 支付结果
typedef NS_ENUM(NSInteger, PaymentResult) {
    PaymentResult_Success = 1,                  // 支付成功
    PaymentResult_Cancel = 2,                   // 取消支付
    PaymentResult_Error = 3,                    // 支付失败
};


typedef enum
{
    typeRecommendSDRSupply=0,
    typeRecommendSDRDemand,
    typeRecommendSDRProduct,
    typeRecommendViaVipServerSupply,
    typeRecommendViaVipServerDemand,
    typeRecommendViaVipServerProduct,
}eTypeRecommendSDR;

typedef enum
{
    eTypeWeiboApiUpload=0,
    eTypeWeiboApiUpdate,
}eTypeWeiboApi;


typedef NS_ENUM(NSInteger, OpcodeTimeLineType)
{
    opcodeTimeLineTypeUnknown=-2,             //未知版本，即当前版本不支持的类型 new
    opcodeTimeLineConnectionCollection=-1,//人脉交换集合   new
    opcodeTimeLineUserProfile=0,
    opcodeTimeLineConnection=1,
    opcodeTimeLineMeetingCheckin=2,
    opcodeTimeLineMeetingMark=3,
    opcodeTimeLineUserComment=4,
    opcodeTimeLineMeetingComment=5,
    opcodeTimeLineWeiboLinkedIn=6,
    opcodeTimeLineSupply=7,
    opcodeTimeLineStatus=8,//new
    opcodeTimeLineTimelineComment=9,
    opcodeTimeLineProduct=10,//new
    opcodeTimeLineArticleShare=11,
    opcodeTimeLineQQ=12,
    opcodeTimeLineAuth=13,
    opcodeTimeLineUnknow=14,
    opcodeTimeLineGroup=15,//new
    opcodeTimeLinePraise=17,
    opcodeTimeLineCompanyAuth=18,
    opcodeTimeLineBeMember = 20,//花钱买的会员
    opcodeTimeLineAdvertisement    =21,
    opcodeTimeLineRecommendInviteUser    =22,
    opcodeTimeLineBeMemberViaInviteUser    =23,//邀请别人获赠会员
    opcodeTimeLineSocialBind    =24,
    opcodeTimeLineSpread        =25,//动态扩散  new
    opcodeTimeLineSpreadProduct        =26,//商品扩散
    opcodeTimeLineIndustryNews   =27,      //行业新闻,1.63版本追加  new
    opcodeMeetingComment           =1001,
    opcodeCommentReplay            =1000,
    opcodeTimeLineProfileComment   =1002,
    opcodeGroupTopicProfileComment =1003,
    opcodeSDRCommentAtCommentCenter=1004,
    
    //手动添加的类型
    opcodeTimeLineRecommentProduct  =   3001,   // 推广商品  new
    opcodeTimeLineRecommentPurchase =   3002,   // 推广采购  new
    opcodeTimeLineAdBanner          =   3003,   // 在动态中插入的广告banner
    opcodeTimeLineAdInTimelineFeed  =   3004,   // 在动态feed流中插入的广告类型；@since1.800
    
};

//动态扩散类型
NS_ENUM(NSInteger, SPREAD_TYPE){
    SPREAD_TYPE_SUPPLY_DEMOND   =   7,  //动态：供求扩散
    SPREAD_TYPE_STATUS          =   8,  //动态：每日签名扩散
    SPREAD_TYPE_PRODUCT         =   10, //动态：商品扩散
};

typedef enum
{
    //      旧版本 无 gtype  -1
    //    评论回复	comment	0
    //    会议评论	meeting 1
    //    动态评论	cast	2
    //    群组话题评论	grouptopic	3
    //    供求评论	sdr	4
    gtypeTimelineCommentUndefine=-1,
    gtypeTimelineCommentCommentReplay=0,
    gtypeTimelineCommentMeetingComment,
    gtypeTimelineCommentComment,
    gtypeTimelineCommentGroupTopic,
    gtypeTimelineCommentSDR,
}gtypeTimelineComment;

typedef enum
{
    eTypeOpcodeTimeLineRecommendInviteUserInviteBeMember = 3,
}eTypeOpcodeTimeLineRecommendInviteUser;

typedef enum
{
    socialTypeTimelineArticleShareLike = 0,
    socialTypeTimelineArticleShareWeibo = 1,
    socialTypeTimelineArticleShareWeChat = 2,
    socialTypeTimelineArticleShareLinkedIn = 3,
    socialTypeTimelineArticleShareQQ = 4,
}socialTypeTimelineArticleShare;

typedef enum
{
    typeRemoveGroup4Comment=1,
    typeRemoveGroup4Replay,
}typeRemoveGroupComment;

typedef enum
{
    typeSDRfromTimelineId=0,
    typeSDRfromUserUid,
}typeSDRfrom;

typedef enum
{
    typeBindContactPhone=1,
    typeBindContactMail,
    typeBindContactPhone4Credit,
}typeBindContact;

typedef enum
{
    typeGroupInviteStateUnKnown = 0,
    typeGroupInviteStateNone = 1,
    typeGroupInviteStateInvited = 2,
}typeGroupInviteState;

typedef enum
{
    typeAccountVerifyUserInfoCellNameCn=0,
    typeAccountVerifyUserInfoCellNameEn,
    typeAccountVerifyUserInfoCellCompany,
    typeAccountVerifyUserInfoCellJob,
    typeAccountVerifyUserInfoCellPhone,
    typeAccountVerifyUserInfoCellMail,
}typeAccountVerifyUserInfoCell;

typedef enum
{
    typeLeftSysToolChat=0,
    typeLeftSysToolRequest,
    typeLeftSysToolComment,
    typeLeftSysToolSysNofity,
    typeLeftSysToolSetting,
}typeLeftSysTool;

typedef enum
{
    typeOpcode17Timeline = 0,
    typeOpcode17GroupTopic,
    typeOpcode17SDR,
}typeOpcode17;

typedef enum
{
    //socialType !=0  分享至社交网络
    //1:新浪微博，2:weChat，3:LinkedIn
    typeSQTLikeTypeNormal=0,
    typeSQTLikeTypeWeibo,
    typeSQTLikeTypeWeChat,
    typeSQTLikeTypeLinkedIn,
    typeSQTLikeTypeQQ,
}typeSQTLikeType;

typedef enum
{
    //    0	sinaWeiboId	新浪微博
    //    1	linkedInId	Linkedin
    //    2	qqOpenId	qq
    //    3 facebook
    //    4 twitter
    typeSocialTokenWeibo=0,
    typeSocialTokenLinkedIn,
    typeSocialTokenQQ,
    typeSocialTokenFacebook,
    typeSocialTokenTwitter
}typeSocialToken;
typedef enum
{
    //    0	sinaWeiboId	新浪微博
    //    1	linkedInId	Linkedin
    //    2	qqOpenId	qq
    //    3 facebook
    //    4 twitter
    typeSocialWeibo=0,
    typeSocialLinkedIn,
    typeSocialQQ,
    typeSocialFacebook,
    typeSocialTwitter
}typeSocial;

typedef enum
{
    SysCastMsgType_SysCastCountGroup = 0,        // 群组话题，群活动有新内容    <<--已经废弃
    SysCastMsgType_SysCastCountGropuNewMemberRequest = 1,  // 群组管理员申请，入群申请   <<--已经废弃
//    MsgType_NewBidOfMyPurchase_InCmdA  = 2,      // 我的采购收到的新的竞标个数 @since 1.70 关闭
    MsgType_InterestingWithMyBid_InCmdA = 3,     // 采购商对我的竞标感兴趣的个数；（是产品的个数，不是采购商的个数）
//    MsgType_NewPurchaseChance_InCmdA = 4,        // 采购机会的个数 1.70版本之前定义的
    MsgType_NewPurchaseChanceInMsgCenter_InCmdA = -4,        // 采购机会的个数 1.70版本之前定义的，1.70后，用于消息中心的新采购类型
    MsgType_BasePriceBarganCount_InCmdA = 5,     // 初始化返回的时候  询价/报价的基数类型
    
    MsgType_NewBidOfMyPurchase_InCmdA  = 6,      // 我的采购收到的新的竞标个数 @since V1.700
    MsgType_NewPurchaseChanceInGrabList_InCmdA = 7,        // @since V1.700 采购机会的个数 用于在抢单列表显示小气泡；注意区分newPurchaseChance节点，newPurchaseChance节点用于在消息中心显示数字气泡；

}SysCastMsgType;

typedef enum {
    MsgType_AskPriceForMyPurchase_InCmdE = 7,    // 产品有人询价/你的询价有了新的报价
    MsgType_NewBidOfMyPurchase_InCmdE = 9 ,      // 我的采购收到新的报价
    MsgType_InterestingWithMyBid_InCmdE = 10,    // 采购商对我的竞标感兴趣
}SocketMsgE;

typedef enum
{
    //用户在群组中的身份
    typeGroupRoleStranger =-1,
    typeGroupRoleInRequest,
    typeGroupRoleMember,
    typeGroupRoleManager,
    typeGroupRoleFounder,
    
}typeGroupRole;
typedef enum
{
    typeGroupEventProfileFromEventId=0,
    typeGroupEventProfileFromEventUnit,
    
}typeGroupEventProfile;
typedef enum
{
    typeInviteFriendButtonAdd=0,
    typeInviteFriendButtonInvite,
    typeInviteFriendButtonAdded,
    typeInviteFriendButtonInvited,
    
}typeInviteFriendButton;
typedef enum
{
    //赞列表中 区分动态赞 和群组话题赞
    typeTimeLineUnitNormal=0,
    typeTimeLineUnitGroupTopicPraise, //1：群体赞，
    typeTimeLineSDRPraise,  // 2：供求赞
    typeTimeLineSpreedPraise //3：动态扩散
    
}typeTimeLineUnit;

//undo, // 初始化未处理
//accept, // 同意交换名片请求
//ignore, // 忽略请求
//viewed, // 同意信息已查看
//clientRefuse,//客户端处理时已占用
//recommend //推荐

typedef enum
{
    //名片交换请求与群组申请通用  用于区分类型
    typeRequestCellNewCardRequest=0,
    typeRequestCellNewCardAccept,
    typeRequestCellNewCardRefuse,
    typeRequestCellNewCardOtherAccess,
    typeRequestCellNewCardMyRefuse,
    typeRequestCellNewCardRecommend,
    typeRequestCellGroupRequest = 100,
}typeRequestCell;
typedef enum
{
    sourceTypeRequestCellDefault=0,
    sourceTypeRequestCellRmtUser,
    sourceTypeRequestCellRmtFriend,
    sourceTypeRequestCellPhonebook,
    sourceTypeRequestCellWeibo,
    sourceTypeRequestCellLinkedIn,
    sourceTypeRequestCellQQ,
    sourceTypeRequestCellCardCase,
}sourceTypeRequestCell;
typedef enum
{
    //群组动态类型
    typeGroupTimelineGroupInfo=0,
    typeGroupTimelineGroupEvent,
    typeGroupTimelineGroupTopic,
    typeGroupTimelineJoinGroup,
    typeGroupTimelineJoinEvent,
}typeGroupTimeLine;
typedef enum
{
    typeGroupTopicCellTableList =0,
    typeGroupTopicCellTopicProfile
}typeGroupTopicCell;
typedef enum
{
    opCodeGroupTopic=1024,
}opCodeType;
typedef enum
{
    GroupSectionTitle=0,
    GroupSectionDescription,
    GroupSectionManager,
    GroupSectionMembers,
    GroupSectionJoin,
    GroupSectionEvents,
    GroupSectionTopics,
    GroupSectionNotice,
    GroupSectionExit,
    GroupSectionType,
}GroupProfileSectionType;
typedef enum
{
    GroupProfileViewControllerTypeProfile   =0,
    GroupProfileViewControllerTypeInfo,
    GroupProfileViewControllerTypeInfoEdit,
    GroupProfileViewControllerTypeNotice,
    GroupProfileViewControllerTypeUserList,
    GroupProfileViewControllerTypeUserListEdit,
    GroupProfileViewControllerTypeEventsList,
}GroupProfileViewControllerType;
typedef enum
{
    typeGroupEventsProfileCellName  =0,
    typeGroupEventsProfileCellDescription,
    typeGroupEventsProfileCellPlace,
    typeGroupEventsProfileCellTime,
    typeGroupEventsProfileCellMembers,
    typeGroupEventsProfileCellDelete,
    typeGroupEventsProfileCellJoin,
}typeGroupEventsProfileCell;
typedef enum
{
    typeGroupEventProfileSectionBasic = 0,
    typeGroupEventProfileSectionMember,
}typeGroupEventProfileSection;
typedef enum
{
    typeEditStatusNormal    =0,
    typeEditStatusEditing,
}typeEditStatus;

typedef enum
{
    typeParm4UserProfileAccountVerifyEmailAddress=0,
    typeParm4UserProfileAccountVerifyEmail2nd,
    typeParm4UserProfileAccountVerifyEmail3nd,
    typeParm4UserProfileAccountVerifyMobilePhone,
    typeParm4UserProfileAccountVerifyOtherPhone1st,
    typeParm4UserProfileAccountVerifyOtherPhone2nd,
    typeParm4UserProfileAccountVerifyOtherPhone3rd,
}typeParm4UserProfileAccountVerify;
typedef enum
{
    typeGroupBaseInfoCreat=0,
    typeGroupBaseInfoUpdate,
    typeGroupBaseInfoHomePage
}typeGroupBaseInfo;

typedef enum
{
    CommercialProfileToolbarButtonAdd2AddressBook= 0,
    CommercialProfileToolbarButtonSendMessage,
    CommercialProfileToolbarButtonAdd2Contact,
    CommercialProfileToolbarButtonAccept,
    CommercialProfileToolBarButtonReject,
    CommercialProfileToolbarButtonMoreFunc,
    CommercialProfileToolbarButtonSendSuperMessage,
    CommercialProfileToolbarButtonAcceptJionGroupChat,
    CommercialProfileToolbarButtonRejectJionGroupChat,
}CommercialProfileTollbarButtonType;

typedef enum{
    CONTACTS_FROM_FRIENDS = 0,
    CONTACTS_FROM_CARDBOX,
    CONTACTS_FROM_MOBILE
} ENUM_CONTACT_SOURCE;
typedef enum{
    ENUM_OfflineCall_ViaPhone = 0,
    ENUM_OfflineCall_ViaMessage = 1,
    ENUM_OfflineCall_4Group = 2,
    ENUM_OfflineCall_ShowGetFreeVip = 3,
    ENUM_OfflineCall_ShowGetFreeVipNewRegister = 4,//1.730新增，新注册用户邀请好友用来区分我Tab进入
} ENUM_OfflineCall_TYPE;
typedef enum{
    ProductListAll = 0,
    ProductList4Industry,
    ProductList4Search,
    ProductList4Search_New,
    ProductList4ProductRecommend,
    ProductList4ProductRecommendViaVIP,
    ProductList4MyShop,
    ProductList4FriendShop,
    ProductList4Bid,//从抢单报价输入界面进入
} ENUM_ProductList_Type;
typedef enum {
    USED_FOR_STATUS = 0,
    USED_FOR_OPPORTUNITY
} ScreenMode;

typedef NS_ENUM(NSInteger, EnumRegisterType) {
    RegisterTypeNormal=0,
    RegisterTypeWeChat,
    RegisterTypeWeibo,
    RegisterTypeLinkedIn,
    RegisterTypeTencent,
    RegisterTypeFacebook,
    RegisterTypeTwitter
};

typedef enum {
    Supply = 0,
    Demand,
    Recruitment
}ENUM_Opportunity;

typedef enum{
    Regist_Normal = 0,
    Regist_Sns
}ENUM_RegistMode;//注册的模式

typedef enum{
    USER_SEARCH_MODE_BY_COMPANY = 0,
    USER_SEARCH_MODE_BY_NAME ,
    USER_SEARCH_MODE_BY_CITY,
    USER_SEARCH_MODE_BY_SUPPLY,
    USER_SEARCH_MODE_BY_DEMAND,
    USER_SEARCH_MODE_BY_RECRUITMENT,
    USER_SEARCH_MODE_BY_PRODUCT,
    USER_SEARCH_MODE_BY_ADVANCED
}ENUM_USER_SEARCH_MODE;
typedef enum
{
    typeGroupOwnAll=1,
    typeGroupOwnNormalMember,
    typeGroupOwnNormalManager,
    typeGroupOwnNormalOwner,
    typeGroupOwnNormalOwnerAndManager,
}typeGroupOwn;
typedef enum{
    TYPE_SearchBar_People = 0,
    TYPE_SearchBar_Supply,
    TYPE_SearchBar_Product,
}ENUM_SearchBarType;
//评论列表类别
typedef enum {
    COMMENT_LIST_MEETING = 0,
    COMMENT_LIST_CAST,
    COMMENT_LIST_SDR
}ENUM_COMMENT_LIST_TYPE;
//枚举值和服务器端消息定义是一致的
typedef enum {
    COMPLAINT_BY_TRANBID = 1,
    COMPLAINT_BY_MSGID
}ENUM_COMPLAINT_MODE;
//名片交换请求处理
typedef enum {
    REQUEST_PROGRESS_ACCEPT = 1,
    REQUEST_PROGRESS_REFUSE = 2,
}ENUM_REQUEST_PROGRESS;
//私信的类型(仅客户端内部使用)；
typedef enum{
    MSG_TYPE_TXT = 0,
    MSG_TYPE_IMG,
    MSG_TYPE_AUDIO,
    MSG_TYPE_Bid = 3,//竞标
    MSG_TYPE_Purchase = 4,//采购
    MSG_TYPE_RECOMMEND_CONTACTS = 10,//推荐人脉
    MSG_TYPE_NORMAL = 11,//普通消息？？？？服务器端未实现.... 小马说是可能是为以后高级客服之类的预留的...
    MSG_TYPE_COMPLETE_USERPROFILE = 12,//完善个人资料
    MSG_TYPE_PURCHASEINFO = 15 //采购私信回推
}ENUM_MSG_TYPE;


typedef enum{
    MeetingList_Date_Future=2,
    MeetingList_Date_Past=1,
    MeetingList_Date_All=0//default
} ENUM_MEETINGLIST_DATE;
typedef enum{
    MeetingList_OrderType_ASC=0,//default
    MeetingList_OrderType_DESC=1,
    
} ENUM_MEETINGLIST_ORDERTYPE;
typedef enum{
    MeetingList_OrderFiledType_Default=0,//default
    MeetingList_OrderFiledType_Time=1,//default
    MeetingList_OrderFiledType_CheckInCOunt=2,//default
} ENUM_MEETINGLIST_ORDERFILEDTYPE;

//修改联系人界面的类型；
typedef enum{
    EDIT_CONTACT = 0,
    EDIT_CARD,
    EDIT_MOBILE_CONTACT,
    NEW_CONTACT,
    NEW_CARD,
    NEW_MOBILE_CONTACT,
    SHOW_CONTACT_ONLY,   //仅显示客户信息，不可进入编辑状态；
    SHOW_CARD_ONLY,
    SHOW_MOBILE_CONTACT_ONLY,
    EditModel_EditMyCard,
    EditModel_EditTmpCard
} ENUM_EDIT_MODE_PROFILE;

//图片的尺寸
typedef enum{
    IMG_SIZE_SMALL = 0,
    IMG_SIZE_MEDIUM,
    IMG_SIZE_BIG
}ENUM_IMG_SIZE;

typedef enum {
    TypePhotoAvatar     =    100,
    TypePhotoCard
}ENUM_PHOTO_TYPE;

//dictTagBinaryIndex=@{NSLocalizedString(@"新消息提示声音",@""):@"2",
//                     NSLocalizedString(@"集中推送",@""):@"3",
//                     NSLocalizedString(@"免打扰模式",@""):@"4",};
typedef enum{
    BinaryPrivacyEmail = 0,
    BinaryPrivacyPhone = 1,
    BinaryPrivacyPushVoice =2,
    BinaryPrivacyCentralizedPush=3,
    BinaryPrivacyNoDisturb=4,
    BinaryPrivacySameIndustry=5,
    BinaryPrivacySameCity=6,
    BinaryPrivacyAllowAll=7,
}BinaryPrivacy;

//群组类型定义
typedef enum
{
    GroupTypeOfficial = 0,   //官方群
    GroupTypeIndustry = 1,   //行业群
    GroupTypeCity = 2,       //地域群
    GroupTypeMeeting = 3,    //聚会群
    GroupTypePadding = 4     //正在等待审核的群
}GroupType;

#pragma mark - 采购及抢单
//采购状态
typedef NS_ENUM(NSInteger,PurchaseState) {
    PurchaseState_InPurchasing = 0, //采购中
    PurchaseState_IHaveFoundIt = 1, //我已找到
};

/* 
 审核状态
 server端审核状态变动时，不会影响采购状态的值
*/
typedef NS_ENUM(NSInteger,PurchaseReviewState) {
    PurchaseReviewState_WechatBusinessOnOtherIndustry = -3,  //微商发布采购分类选择了不是微商的行业
    PurchaseReviewState_CannotGetInTouch              = -2,  //无法建立联系
    PurchaseReviewState_Refused                       = -1,  //审核被拒
    PurchaseReviewState_Pending                       = 0,   //新待审采购
    PurchaseReviewState_AuditSuccess                  = 1    //审核通过
};

//选择主营
typedef NS_ENUM(NSInteger,CategoryPanelType) {
    /**
     //单选，选择商品分类是单选的，显示到3级分类；有一个特殊情况：当遇到面料分类时，面板要变成多选， 尽针对面料行业，显示到3级分类，3级分类使用tag的形式展现；
     */
    CategoryPanelType_3Level        = 0, 
    CategoryPanelType_ZhuYing       = 1, //多选，选择主营分类是多选的，显示到2级分类
    CategoryPanelType_Single_HotTag = 2, //单选，但是和多选的UI绘制相同，显示到2级分类
    CategoryPanelType_GYCF          = 3, //已经废弃 @since 1.723 多选，工艺成份，使用tag的形式，显示到3级分类
    CategoryPanelType_ProductEdit   = 4, //单选，规则同3Level,不同的地方是面料分类不能选成份和工艺
    CategoryPanelType_BrowsProduct  = 5, //单选，面料三级是单选，选完不会跳成分工艺页面,面料多选，其他单选；显示到3级；其中，面料分类：面料，辅料；面料多选，辅料单选；
};

typedef NS_ENUM(NSInteger,JPushPushType) {
    /** 发送好友请求： 13*/
    JPushType_friendRequest = 13,
    
    /** 接受好友请求： 14*/
    JPushType_acceptFriend = 14,
    
    /** 屏蔽用户：15 */
    JPushType_blockUser = 15,
    
    /** 取消屏蔽：16*/
    JPushType_cancelBlockUser = 16,
    
    /** 入群申请   1 **/
    JPushType_GroupApply = 1,
    
    /**  type = 2，表示群主或管理员变；修改群资料；删除群；客户端要刷新群资料
     （如果群被删除了，或群id不正确 code=90014, groupInfo 返回空，客户端刷新资料后判断groupInfo为空，删除此群聊天） **/
    JPushType_GroupInfoChanged = 2,
    
    /**待评价的采购或报价*/
    JPushType_uncommentPurchaseAndBid = 102,
    
};

typedef NS_ENUM(NSInteger,APNSPushType) {
    /** 新采购机会 **/
    APNSPushType_newPurchaseChance  = 100,
    
    /** 采购有新报价 **/
    APNSPushType_newBid             = 101,
    
    /**新订单消息*/
    APNSPushType_OrderMessage       = 103
};

typedef NS_ENUM(NSInteger,APNSPush_SType) {
    /** 收到私信 **/
    APNSPush_SType_MSG = 1,
    
    /** 收到名片交换请求 **/
    APNSPush_SType_CardExchange = 2,
    
    /** 收到系统消息 **/
    APNSPush_SType_SysNotification = 3,
    
    /** 收到评论通知 **/
    APNSPush_SType_Comment = 4,
    
    /** 收到赞通知 **/
    APNSPush_SType_Praise = 5,
    
    /** 商业资讯推送 **/
    APNSPush_SType_SQT = 6,
    
    /** 1.70过期 询价/报价 **/
    APNSPush_SType_AskPrice = 7,
    
    /** 1.70过期 表示“您采购的商品[XXX]，收到1条新的竞标信息，点击查看详情” **/
    APNSPush_SType_BidOfMyPurchase = 9,
    
    /** 1.70过期 表示“恭喜您，采购商对您的竞标商品[XXX]有兴趣，请尽快联系TA，点击查看详情” **/
    APNSPush_SType_FavorOfMyBid = 10,
    
    /** 1.70过期 表示“你有一条新采购机会” **/
    APNSPush_SType_PurchaseChance = 11,
    
    /** 点击本地通知 进入完善个人信息界面 **/
    APNSPush_SType_PersonalInfo = 31
};

typedef NS_ENUM(NSInteger,UIEditMode){
    UIEditMode_OnlyShow  = 0,
    UIEditMode_New       = 1,
    UIEditMode_Edit      = 2,
};


#pragma mark 商品
/** Section Type 定义 */
typedef NS_ENUM(NSInteger,ProductSectionType) {
    ProductProfileSectionType_Unknown = -1,
    ProductProfileSectionType_Name = 0,
    ProductProfileSectionType_Dynamics = 1,//根据类目设置的规则及server端配置的动态属性来填充
    ProductProfileSectionType_Tags = 2,
    ProductProfileSectionType_DetailInfo = 3,//商品详细信息，如描述、图片等
    ProductProfileSectionType_PhoneNumber = 4,//手机号
    ProductProfileSectionType_DeleteButton = 5, //删除商品
    ProductProfileSectionType_CarModelCode = 6,  //适用车型
    ProductProfileSectionType_ContactInfo  = 7  //商品所有人信息
    
};

/** Row Type 定义 */
typedef NS_ENUM(NSInteger, ProductProfileCellType) {
    ProductProfileCellTypeUnknown = -1,
    ProductProfileCellTypeIndustry = 0,     // 行业
    ProductProfileCellTypeName=1,             // 商品名称
    ProductProfileCellTypeImages=2,           // 商品图片
    ProductProfileCellTypeBusinessModel=3,    // 经营模式(v1.6版本已被砍掉)
    ProductProfileCellTypeBrand=4,            // 品牌
    ProductProfileCellTypeProductArea=5,      // 所在地
    ProductProfileCellTypeSalesArea=6,        // 销售区域
    ProductProfileCellTypeOnlineTime=7,       // 发布日期(v1.6版本已被砍掉)
    ProductProfileCellTypeExpiryTime=8,       // 有效日期(v1.6版本已被砍掉)
    ProductProfileCellTypeSupportUnit=9,      // 单位
    ProductProfileCellTypeSupportMin=10,       // 最小起订量
    ProductProfileCellTypeSupportMax=11,       // 最大供货量(v1.6版本已被砍掉)
    ProductProfileCellTypeSupportCount=12,     // 最大起订量－最小起订量 单位
    ProductProfileCellTypeTags=13,             // 标签
    ProductProfileCellTypeDescription=14,      // 商品描述
    ProductProfileCellTypePrice=15,            // 单价
    ProductProfileCellUserInfo=16,
    ProductProfileCellTypeSocialIcons=17,
    ProductProfileCellTypeUserInfoPhone=18,
    ProductProfileCellTypeUserButton=19,
    ProductProfileCellTypePhone=20,             // 手机号码
    ProductProfileCellTypeStock = 21,           // 库存
    ProductProfileCellTypeDynamics = 22,        //从服务器端动态拿到的字段，具体字段类型需要结合另外的数据结构来确定
    ProductProfileCellTypeDeleteButton = 23,    //删除商品按钮
    ProductProfileCellTypeSubCategory = 24,     //品类（二级分类的名称）
    ProductProfileCellTypeThirdCategory = 25,   //品名（三级分类的名称）
    ProductProfileCellTypeChengfen = 26,        //成分
    ProductProfileCellTypeGongyi = 27           //工艺
};

typedef NS_ENUM(NSInteger,QiPeiCateogryType) {
    QiPeiCateogryType_BYJ = 1,      //保养件
    QiPeiCateogryType_QCJ = 2       //全车件
};

/**
 需求描述：
 https://tower.im/projects/dbe017efd44044619c565f3e38a48ba5/docs/f49587e7386e48e990357bec39379b3d/
 */
typedef NS_ENUM(NSInteger,WeiShangLimitType){
    /**不care来源的情况下，就统一使用这个type*/
    WeiShangLimitType_fromDefaultScene = 0,
    
    /**用户切换个人行业,需显示行业选择面板*/
    WeiShangLimitType_fromChangePersonIndustry = 1,
    
    /**跨行业动态评论（判断的是这条动态发的人所在的行业）*/
    WeiShangLimitType_fromTimelineComment = 2,
    
    /**跨行业报价（判断的是这条采购发的人所在的行业，不管这条采购所属的商品行业）*/
    WeiShangLimitType_fromQuote = 3,
    
    /**跨行业加人脉*/
    WeiShangLimitType_fromAddFriend = 4,
    
    /**跨行业询价（判断的是这条商品发的人所在的行业，不管这条商品所属的商品行业）*/
    WeiShangLimitType_fromAskPrice = 5
};


//我的采购报价详情界面入口
typedef NS_ENUM(NSInteger,EnterMyPurchaseProfileType) {
    EnterMyPurchaseProfiletype_Unknown = -1,    //未知来源，
    EnterMyPurchaseProfileType_MyPurchaseList = 0, //从我的采购列表进入
    EnterMyPurchaseProfileType_MessageCenterNewBidList = 1, //从消息中心新报价列表进入
    EnterMyPurchaseProfileType_NewPurchase = 2, //发布新采购

};

#pragma mark 广告
typedef NS_ENUM(NSInteger,AdContentType){
    /**未知广告内容类型*/
    AdContentType_Unknown = 0,
    /**纯文本广告*/
    AdContentType_Text    = 1,
    /**GIF动图广告*/
    AdContentType_GIF     = 2,
    /**静态图片*/
    AdContentType_StaticImage = 3,
    /**MP4视频*/
    AdContentType_VideoMp4    = 4
};


/**
 接口定义：@since 1.800
 http://192.168.254.120:8080/smartKit-api/api/578f302e975a15797c54d741/apiDetail/
 */
typedef NS_ENUM(NSInteger,AdShowedPosition){
    /**未定义*/
    AdShowedPosition_Unknown = -1,
    /**开屏广告—支持图片、GIF、视频格式*/
    AdShowedPosition_StartUp = 0,
    /**动态信息流广告*/
    AdShowedPosition_TimelineBanner = 1,
    /**浏览商品广告位*/
    AdShowedPosition_ProductBrowserTopBanner = 2,
    /**动态Feed流*/
    AdShowedPosition_TimelineFeed = 3,
    /**浏览商品，商品瀑布流中的cell中的置顶广告位*/
    AdShowedPosition_ProductBrowserFlow = 4,
    /**群聊广告位*/
    AdShowedPosition_GroupChat = 5,
    /**资讯广告位*/
    AdShowedPosition_IndustryNewsTopBanner = 6,
    /**资讯详情广告位*/
    AdShowedPosition_IndustryNewsProfile = 7,
    /**发送的私信关键词，推送用户商品*/
    ASShowedPosition_chatKeywords = 8,
    /**买卖信息，购买信息关键词*/
    AdShowedPosition_SD_Keywords = 9,
    /**消息中心banner*/
    AdShowedPosition_MsgCenterBanner = 10,
    /**资讯信息流广告*/
    AdShowedPosition_IndustryNewsFeeds = 11,
};

#endif
