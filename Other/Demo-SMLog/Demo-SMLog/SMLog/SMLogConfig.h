//
//  SMLogConfig.h
//  Demo-SMLog
//
//  Created by buding on 15/7/31.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#ifndef Demo_SMLog_SMLogConfig_h
#define Demo_SMLog_SMLogConfig_h

#import "SMLogSys.h"

#define __ON__      (1)
#define __OFF__     (0)

// 总开关
#define __DUBUG__               (__ON__)

// 输出到控制台
#define __OUT_CMD__             (__ON__)
// 输出到文件（在沙盒/Debug/SMLog/）
#define __OUT_FILE__            (__ON__)
// 输出到指定路径（真机调试下失效）
#define __OUT_FILE_PATH__       (__ON__)
// 输出路径
#define __PATH_FOR_OUT_FILE__   @"~/SMLog/Demo-SMLog/"

#define SMLogHeader             @""
#define SMFunctionName          (SMToString(@"%s", __PRETTY_FUNCTION__))
#define SMToString(a...)        ([NSString stringWithFormat:a])
#define SMLog(lg...)            ([SMLogSys log:lg fcName:SMFunctionName])

// 字符串转日期
#define SMStringToDate(dateString,formatString) ({NSDate * date = nil; NSDateFormatter * formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:(formatString)];date = [formatter dateFromString:(dateString)];date;})
// 日期转字符串
#define SMDateToString(date,formatString) ({NSString * dateString = nil; NSDateFormatter * formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:(formatString)];dateString = [formatter stringFromDate:(date)]; dateString;})
// 字符串日期格式化字符串
#define SMDateStringToString(dateString,formatString) WpDateToString(WpStringToDate(dateString, formatString), formatString)

#endif
