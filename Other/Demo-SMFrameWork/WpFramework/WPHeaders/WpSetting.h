//
//  WpSetting.h
//  WisdomPark
//
//  Created by 丁治文 on 15/1/24.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#ifndef WisdomPark_WpSetting_h
#define WisdomPark_WpSetting_h

/********************************************************************************
 ||
 ||                              开关变量
 VV
 *******************************************************************************/
// 开
#undef	__ON__
#define __ON__		(1)
// 关
#undef	__OFF__
#define __OFF__		(0)

/********************************************************************************
 ||
 ||                               LOG开关
 VV
 *******************************************************************************/
// log开关
#define __WP_SWITCH_LOG__ ( __ON__ )
// warming(警告) log开关
#define __WP_SWITCH_WARMING_LOG__ ( __ON__ )
// error(错误) log开关
#define __WP_SWITCH_ERROR_LOG__ ( __ON__ )
// debug(调式) log开关
#define __WP_SWITCH_DEBUG_LOG__ ( __ON__ )

/********************************************************************************
 ||
 ||                                 LOG
 VV
 *******************************************************************************/
#define WpLogHeader @"%@:%@:%@"
#define WpLogString @"***WpLog"
#define WpWarmLogString @"***WpLog警告"
#define WpErrorLogString @"***WpLog错误"
#define WpDebugLogString @"***WpLog调式"

#define WpToString(a...) [NSString stringWithFormat:a]

#define WpFunctionName WpToString(@"%s", __PRETTY_FUNCTION__)

// log
#if __WP_SWITCH_LOG__
#define WpLog(a...) NSLog (a)
#else
#define WpLog(a...)
#endif
// warming(警告) log
#if __WP_SWITCH_WARMING_LOG__
#define WpWarmLog(a...) WpLog(WpLogHeader, WpWarmLogString, WpFunctionName, WpToString(a))
#else
#define WpWarmLog(a...)
#endif
// error(错误) log
#if __WP_SWITCH_ERROR_LOG__
#define WpErrorLog(a...) WpLog(WpLogHeader, WpErrorLogString, WpFunctionName, WpToString(a))
#else
#define WpErrorLog(a...)
#endif
// debug(调式) log
#if __WP_SWITCH_DEBUG_LOG__
#define WpDebugLog(a...) WpLog(WpLogHeader, WpDebugLogString, WpFunctionName, WpToString(a))
#else
#define WpDebugLog(a...)
#endif

/********************************************************************************
 ||
 ||                                url配置
 VV
 *******************************************************************************/
// URL
// 北园区
#define __WP_BASEURL_NORTH_ @"http://211.99.30.132:80/"
// 南园区
#define __WP_BASEURL_SOUTH_ @"http://211.99.30.132:80/"
// 本地数据local
#define __WP_BASEURL_0_ @"local"
// 服务器测试165
#define __WP_BASEURL_1_ @"http://192.168.67.165:80/"
// 服务器测试131
#define __WP_BASEURL_2_ @"http://192.168.67.131:18080/"
// 测试张星曼
#define __WP_BASEURL_3_ @"http://192.168.69.34:9000/"
// 测试刘高峰
#define __WP_BASEURL_4_ @"http://192.168.69.28:9000/"
// 测试蒋洋
#define __WP_BASEURL_5_ @"http://192.168.69.30:9000/"

// url配置
#define WpPosionNorth @"北园区"
#define WpPosionSouth @"南园区"
#define WpPosion0 @"测试local"
#define WpPosion1 @"测试165"
#define WpPosion2 @"测试131"
#define WpPosion3 @"测试张星曼"
#define WpPosion4 @"测试刘高峰"
#define WpPosion5 @"测试蒋洋"

// 切换地区的配置
#define WpPosionSwitchDataSource @{    \
    WpPosionNorth: __WP_BASEURL_NORTH_,\
    WpPosionSouth: __WP_BASEURL_SOUTH_,\
    WpPosion0    : __WP_BASEURL_0_,    \
    WpPosion1    : __WP_BASEURL_1_,    \
    WpPosion2    : __WP_BASEURL_2_,    \
    WpPosion3    : __WP_BASEURL_3_,    \
    WpPosion4    : __WP_BASEURL_4_,    \
    WpPosion5    : __WP_BASEURL_5_    \
}
// 基本地址
#define WpBaseUrl ([WpPosionSwitchDataSource objectForKey:[WPUserSession userSessionFromUserDefaults].position])

/********************************************************************************
 ||
 ||                                其它设置
 VV
 *******************************************************************************/


#endif
