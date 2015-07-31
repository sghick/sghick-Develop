//
//  SMLogConfig.h
//  Demo-SMLog
//
//  Created by buding on 15/7/31.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#ifndef Demo_SMLog_SMLogConfig_h
#define Demo_SMLog_SMLogConfig_h

#define __ON__      (0)
#define __OFF__     (1)

// 总开关
#define __DUBUG__               (__ON__)

// 输出到文件（在沙盒/Debug/SMLog/）
#define __OUT_FILE__            (__ON__)
// 输出到控制台
#define __OUT_CMD__             (__ON__)
// 输出到指定路径（真机调试下失效）
#define __OUT_FILE_PATH__       (__ON__)
// 输出路径
#define __PATH_FOR_OUT_FILE__   @"~/SMLog/Demo-SMLog/"

#define SMLog(...)  NSLog

#endif
