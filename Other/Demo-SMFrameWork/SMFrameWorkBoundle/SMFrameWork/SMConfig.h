//
//  SMConfig.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/8.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#ifndef Demo_SMFrameWork_SMConfig_h
#define Demo_SMFrameWork_SMConfig_h

#define __ON__      (1)
#define __OFF__     (0)

#warning 上线前应把值置为 __OFF__
#define __SM_DEBUG__            ( __ON__ )
// ======================================================================== //
// ======================================================================== //
#if __SM_DEBUG__
// 测试服务器
#define __SM_BASEURL_ @"http://www.baidu.com"
// 本地数据
#define __SM_USE_LOCAL_DATA__   ( __OFF__ )
#else
// 网络服务器
#define __SM_BASEURL_ @"http://www.baidu.com"
#endif
// ======================================================================== //
// ======================================================================== //

#endif
