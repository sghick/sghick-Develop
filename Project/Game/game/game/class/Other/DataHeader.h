//
//  DataHeader.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#ifndef game_DataHeader_h
#define game_DataHeader_h

// 最高2位向上取整
#define SMUpNumber(a) ({\
NSInteger rtn = (NSInteger)a;\
if (a > 100) {\
NSString * strNum = SMToString(@"%.0f", a);\
int num1 = [strNum substringToIndex:2].intValue;\
int num2 = [strNum substringFromIndex:2].intValue;\
int mod = num1%5;\
if (mod || num2) {\
num1 = num1 + 5 - mod;\
}\
rtn = SMToString(@"%d%d", num1, num2).intValue - num2;\
}\
rtn;}\
)

// 默认空值
#define SMDefaultText   @"暂无数据"
#define SMDefaultDate   @"None"
#define SMDefaultChar   @"None"
#define SMDefaultNumber @"0"
#define SMDefaultSpace  @" "

// 无警告sendMessage
#define SMNoWarningPerformSelector(target, action, object) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object]; \
_Pragma("clang diagnostic pop") \

//16进制转成color 带alpha
#define SMHexColorWithAlpha(hexColor,a)  (SMRGBColorWithAlpha(((hexColor & 0xFF0000) >> 16), ((hexColor & 0xFF00) >> 8), (hexColor & 0xFF), a))

//16进制转成color
#define SMHexColor(hexColor) (WPHexColorWithAlpha(hexColor, 1.0))

// RGB颜色
#define SMRGBColorWithAlpha(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
// RGB颜色
#define SMRGBColor(r,g,b)  (SMRGBColorWithAlpha(r,g,b,1.0))

// 忽视4x高的比例
#define SMWPHeightScale_Ignore4x ([[UIDevice currentDevice] sms_isIPhone4x]?1.0f:SMHeightScale)

// 字符串转日期
#define SMStringToDate(dateString,formatString) ({NSDate * date = nil; NSDateFormatter * formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:(formatString)];date = [formatter dateFromString:(dateString)];date;})
// 日期转字符串
#define SMDateToString(date,formatString) ({NSString * dateString = nil; NSDateFormatter * formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:(formatString)];dateString = [formatter stringFromDate:(date)]; dateString;})
// 字符串日期格式化字符串
#define SMDateStringToString(dateString,formatString) WpDateToString(WpStringToDate(dateString, formatString), formatString)

// 判断是否为闰年
#define SMIsLeapYear(year) (sm_isLeapYear(year))

// 一天的时间戳
#define SMIntervalOfOneDay (60*60*24)

// 周
#define SMWeeks (@[@"星期", @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"])
// 阴历—月
#define SMLunarMonths (@[@"月份", @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月"])
// 阴历-日
#define SMLunarDays (@[@"日子", @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", \
@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", \
@"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"])

#endif
